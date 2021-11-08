package main

import (
	"database/sql"
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	dbx "github.com/go-ozzo/ozzo-dbx"
)

type basicMetadata struct {
	ID              int64          `db:"id"`
	PID             string         `db:"pid"`
	CollectionFacet sql.NullString `db:"collection_facet"`
	RightsURI       string         `db:"uri"`
	Educational     bool           `db:"educational_use"`
	Commercial      bool           `db:"commercial_use"`
	Modification    bool           `db:"modifications"`
	CallNumber      string         `db:"call_number"`
	Barcode         string         `db:"barcode"`
}

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
	qSQL := `select m.id, pid, collection_facet, educational_use, commercial_use, modifications, uri
		from metadata m left outer join use_rights u on u.id = m.use_right_id where pid={:id}
		and date_dl_ingest is not null`
	q := svc.DB.NewQuery(qSQL)
	q.Bind(dbx.Params{"id": key})
	var md basicMetadata
	err := q.One(&md)
	if err != nil {
		if err != sql.ErrNoRows {
			log.Printf("ERROR: other PID %s not found for enriched metadata: %s", key, err.Error())
			c.String(http.StatusInternalServerError, err.Error())
		} else {
			log.Printf("WARNING: other PID %s not found for enriched metadata", key)
			c.String(http.StatusNotFound, fmt.Sprintf("%s not found", key))
		}
		return
	}
	var out struct {
		PDF string `json:"pdfServiceRoot"`
		enrichData
	}
	out.PID = md.PID
	out.PDF = svc.PDFServiceURL
	out.Uses = getUses(&md)

	// published items are required to have an exemplar
	out.ExemplarURL, err = svc.getExemplarThumbURL(md.ID)
	if err != nil {
		log.Printf("ERROR: %s", err)
		c.String(http.StatusInternalServerError, err.Error())
		return
	}

	out.Collection = md.CollectionFacet.String
	iiifURL, err := svc.getIIIFManifestURL(md.PID)
	if err != nil {
		log.Printf("ERROR: Unable to get IIIF manifest for %s: %s", md.PID, err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}
	out.IIIFManURL = iiifURL
	out.UseURI = md.RightsURI

	c.JSON(http.StatusOK, out)
}

func (svc *ServiceContext) getEnrichedSirsiMetadata(c *gin.Context) {
	key := c.Param("key")
	log.Printf("INFO: get enriched sirsi metadata for catalog key %s", key)
	qSQL := `select m.id, pid, collection_facet, barcode, call_number,
		educational_use, commercial_use, modifications, uri
		from metadata m left outer join use_rights u on u.id = m.use_right_id where catalog_key={:id}
		and date_dl_ingest is not null order by call_number asc`
	q := svc.DB.NewQuery(qSQL)
	q.Bind(dbx.Params{"id": key})
	var mdRecs []basicMetadata
	err := q.All(&mdRecs)
	if err != nil {
		if err != sql.ErrNoRows {
			log.Printf("ERROR: sirsi %s not found for enriched metadata: %s", key, err.Error())
			c.String(http.StatusInternalServerError, err.Error())
		} else {
			log.Printf("WARNING: %s not found", key)
			c.String(http.StatusNotFound, fmt.Sprintf("%s not found", key))
		}
		return
	}
	if len(mdRecs) == 0 {
		log.Printf("WARNING: %s not found", key)
		c.String(http.StatusNotFound, fmt.Sprintf("%s not found", key))
		return
	}

	var out struct {
		SirsiID string       `json:"sirsiId"`
		PDF     string       `json:"pdfServiceRoot"`
		Items   []enrichData `json:"items"`
	}
	out.SirsiID = key
	out.PDF = svc.PDFServiceURL
	out.Items = make([]enrichData, 0)

	for _, md := range mdRecs {
		log.Printf("INFO: check for DL published units for metadata catkey %s, PID %s", key, md.PID)
		uq := svc.DB.NewQuery("select count(id) as cnt from units where metadata_id={:mid} and include_in_dl={:in}")
		uq.Bind(dbx.Params{"mid": md.ID})
		uq.Bind(dbx.Params{"in": 1})
		var total int
		uErr := uq.Row(&total)
		if uErr != nil {
			log.Printf("INFO: no published units available for %s: %s", key, uErr.Error())
			continue
		}

		log.Printf("INFO: get enrich data for %s belonging to catkey %s", md.PID, key)
		item := enrichData{PID: md.PID, CallNumber: md.CallNumber, Barcode: md.Barcode, UseURI: md.RightsURI}
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

		item.Uses = getUses(&md)
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

func getUses(md *basicMetadata) []string {
	uses := make([]string, 0)
	if md.Educational {
		uses = append(uses, "Educational Use Permitted")
	}
	if md.Commercial {
		uses = append(uses, "Commercial Use Permitted")
	}
	if md.Modification {
		uses = append(uses, "Modifications Permitted")
	}
	return uses
}
