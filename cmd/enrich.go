package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type enrichData struct {
	PID         string   `json:"pid"`
	CallNumber  string   `json:"callNumber,omitempty"`
	Barcode     string   `json:"barcode,omitempty"`
	Collection  string   `json:"collection,omitempty"`
	Uses        []string `json:"rsUses,omitempty"`
	UseURI      string   `json:"rsURI,omitempty"`
	IIIFManURL  string   `json:"backendIIIFManifestUrl"`
	ExemplarURL string   `json:"thumbnailUrl,omitempty"`
}

func (svc *ServiceContext) getEnrichedOtherMetadata(c *gin.Context) {
	key := c.Param("pid")
	log.Printf("INFO: get enriched other metadata for PID %s", key)
	var mdRec metadata
	mdResp := svc.GDB.Where("pid=? and date_dl_ingest is not null", key).First(&mdRec)
	if mdResp.Error != nil {
		if errors.Is(mdResp.Error, gorm.ErrRecordNotFound) == false {
			log.Printf("ERROR: other PID %s not found for enriched metadata: %s", key, mdResp.Error.Error())
			c.String(http.StatusInternalServerError, mdResp.Error.Error())
		} else {
			log.Printf("WARNING: other PID %s not found for enriched metadata", key)
			c.String(http.StatusNotFound, fmt.Sprintf("%s not found", key))
		}
		return
	}

	// FIXME pull UVAMAP data and parse out rughtsURI

	var out struct {
		PDF string `json:"pdfServiceRoot"`
		enrichData
	}
	out.PID = mdRec.PID
	out.PDF = svc.PDFServiceURL
	out.Collection = mdRec.CollectionFacet
	out.UseURI = "http://rightsstatements.org/vocab/CNE/1.0/" // FIXME use real URI parsed from the UVAMAP data
	// out.Uses = getUses(mdRec.UseRight)  // FIXME change this to take URI as a param, then look up and apply the uses
	var err error

	// published items are required to have an exemplar
	out.ExemplarURL, err = svc.getExemplarThumbURL(mdRec.ID)
	if err != nil {
		log.Printf("ERROR: %s", err)
		c.String(http.StatusInternalServerError, err.Error())
		return
	}

	out.Collection = mdRec.CollectionFacet
	iiifURL, err := svc.getIIIFManifestURL(mdRec.PID)
	if err != nil {
		log.Printf("ERROR: Unable to get IIIF manifest for %s: %s", mdRec.PID, err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}
	out.IIIFManURL = iiifURL

	c.JSON(http.StatusOK, out)
}

func (svc *ServiceContext) getEnrichedSirsiMetadata(c *gin.Context) {
	key := c.Param("key")
	log.Printf("INFO: get enriched sirsi metadata for catalog key %s", key)
	var mdRecs []metadata
	err := svc.GDB.Debug().Joins("inner join units u on u.metadata_id = metadata.id").
		Where("catalog_key=? and date_dl_ingest is not null and include_in_dl=?", key, 1).
		Group("metadata.id").
		Order("call_number asc").Find(&mdRecs).Error
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) == false {
			log.Printf("ERROR: sirsi %s not found for enriched metadata: %s", key, err.Error())
			c.String(http.StatusInternalServerError, err.Error())
		} else {
			log.Printf("WARNING: %s not found", key)
			c.String(http.StatusNotFound, fmt.Sprintf("%s not found", key))
		}
		return
	}

	if len(mdRecs) == 0 {
		log.Printf("WARNING: a published record for %s was not found", key)
		c.String(http.StatusNotFound, fmt.Sprintf("%s not found", key))
		return
	}

	log.Printf("INFO: getMarc for %s to extract use right information", key)
	mdUseRight := svc.CNE
	respBytes, err := svc.getMarc(mdRecs[0])
	if err != nil {
		log.Printf("ERROR: Unable to get MARC for %s, default to CNE: %s", key, err.Error())
	} else {
		mdUseRight, err = svc.getUseRightFromMARC(respBytes)
		if err != nil {
			log.Printf("INFO: unable to extract use righ from marc for metadata %s; default to CNE: %s", key, err.Error())
			mdUseRight = svc.CNE
		}
	}

	var out struct {
		SirsiID    string       `json:"sirsiId"`
		PDF        string       `json:"pdfServiceRoot"`
		Collection string       `json:"collection,omitempty"`
		Items      []enrichData `json:"items"`
	}
	out.SirsiID = key
	out.PDF = svc.PDFServiceURL
	out.Items = make([]enrichData, 0)

	log.Printf("INFO: %d metadata records are associated with %s", len(mdRecs), key)
	for _, md := range mdRecs {
		out.Collection = md.CollectionFacet
		var total int64
		cntResp := svc.GDB.Table("units").Where("metadata_id=? and include_in_dl=?", md.ID, 1).Count(&total)
		if cntResp.Error != nil {
			log.Printf("INFO: no published units available for %s: %s", key, cntResp.Error.Error())
			continue
		}

		log.Printf("INFO: get enrich data for %s belonging to catkey %s", md.PID, key)
		item := enrichData{PID: md.PID, CallNumber: md.CallNumber, Barcode: md.Barcode, UseURI: mdUseRight.URI}
		iiifURL, err := svc.getIIIFManifestURL(md.PID)
		if err != nil {
			log.Printf("ERROR: Unable to get IIIF manifest for %s; skipping: %s", md.PID, err.Error())
			continue
		}
		item.IIIFManURL = iiifURL

		// published items are required to have an exemplar
		item.ExemplarURL, err = svc.getExemplarThumbURL(md.ID)
		if err != nil {
			log.Printf("ERROR: unable to get thumb for %s; skipping: %s", md.PID, err)
			continue
		}

		item.Uses = getUses(mdUseRight)
		out.Items = append(out.Items, item)
	}

	c.JSON(http.StatusOK, out)
}

func (svc *ServiceContext) getIIIFManifestURL(pid string) (string, error) {
	log.Printf("INFO: get cached IIIF metadta for %s", pid)
	url := fmt.Sprintf("%s/pid/%s/exist", svc.IIIFManURL, pid)
	resp, err := svc.getAPIResponse(url)
	if err != nil {
		return "", err
	}
	var parsed struct {
		Exists bool   `json:"exists"`
		Cached bool   `json:"cached"`
		URL    string `json:"url"`
	}
	err = json.Unmarshal([]byte(resp), &parsed)
	if err != nil {
		return "", err
	}

	if !parsed.Exists || !parsed.Cached {
		return "", errors.New("manifest not found")
	}
	log.Printf("INFO: IIIF manifest cached at %s", parsed.URL)
	return parsed.URL, nil
}

func getUses(rights *useRight) []string {
	log.Printf("INFO: get uses for use right %s", rights.Name)
	uses := make([]string, 0)
	if rights.EducationalUse {
		uses = append(uses, "Educational Use Permitted")
	}
	if rights.CommercialUse {
		uses = append(uses, "Commercial Use Permitted")
	}
	if rights.Modifications {
		uses = append(uses, "Modifications Permitted")
	}
	return uses
}
