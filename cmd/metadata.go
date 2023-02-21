package main

import (
	"encoding/csv"
	"encoding/xml"
	"errors"
	"fmt"
	"log"
	"net/http"
	"net/url"
	"regexp"
	"strconv"
	"strings"
	"time"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type subField struct {
	XMLName xml.Name `xml:"subfield"`
	Code    string   `xml:"code,attr"`
	Value   string   `xml:",chardata"`
}

type dataField struct {
	XMLName   xml.Name   `xml:"datafield"`
	Tag       string     `xml:"tag,attr"`
	Subfields []subField `xml:"subfield"`
	Value     string     `xml:",chardata"`
}

type controlField struct {
	XMLName xml.Name `xml:"controlfield"`
	Tag     string   `xml:"tag,attr"`
	Value   string   `xml:",chardata"`
}

type marcMetadata struct {
	XMLName       xml.Name       `xml:"record"`
	Leader        string         `xml:"leader"`
	ControlFields []controlField `xml:"controlfield"`
	DataFields    []dataField    `xml:"datafield"`
}

func (svc *ServiceContext) getExemplar(c *gin.Context) {
	pid := c.Param("pid")
	var minMetadata struct {
		ID int64
	}
	err := svc.GDB.Table("metadata").Where("pid=?", pid).First(&minMetadata).Error
	if err != nil {
		log.Printf("ERROR: unable to get metadata for %s: %s", pid, err.Error())
		return
	}
	url, err := svc.getExemplarThumbURL(minMetadata.ID)
	if err != nil {
		c.String(http.StatusInternalServerError, err.Error())
		return
	}
	c.String(http.StatusOK, url)
}

func (svc *ServiceContext) getMetadata(c *gin.Context) {
	pid := c.Param("pid")
	mdType := c.Query("type")
	if mdType == "" {
		log.Printf("ERROR: Metadata requested without a type")
		c.String(http.StatusBadRequest, "type is required")
		return
	}
	clearCache := false
	if c.Query("nocache") != "" {
		clearCache = true
	}

	// first, see if it is a masterfile pid and pull the metadata pid...
	log.Printf("INFO: check if %s is a master file", pid)
	var mf masterFile
	dbResp := svc.GDB.Preload("Metadata").Joins("left outer join metadata m on m.id = metadata_id").Where("master_files.pid=?", pid).First(&mf)
	if dbResp.Error == nil {
		log.Printf("INFO: %s is a master file. Metadata PID=%s", pid, mf.Metadata.PID)
		pid = mf.Metadata.PID
	} else if errors.Is(dbResp.Error, gorm.ErrRecordNotFound) == false {
		log.Printf("ERROR: metadata query to find masterfile %s failed: %s", pid, dbResp.Error.Error())
		c.String(http.StatusInternalServerError, dbResp.Error.Error())
		return
	}

	// Now get metadata details
	var resp metadata
	dbResp = svc.GDB.Where("pid=?", pid).First(&resp)
	if dbResp.Error != nil {
		if errors.Is(dbResp.Error, gorm.ErrRecordNotFound) == false {
			log.Printf("ERROR: %s not found: %s", pid, dbResp.Error.Error())
			c.String(http.StatusInternalServerError, dbResp.Error.Error())
		} else {
			log.Printf("WARNING: %s not found", pid)
			c.String(http.StatusNotFound, fmt.Sprintf("%s not found", pid))
		}
		return
	}

	// Beyond this point, we have a valid metadata record in TrackSys. Any other
	// issue found after this is an error and should return and log failure instead of not found

	// Simple request for brief metadata on this item
	var err error
	if mdType == "brief" {
		type jsonOut struct {
			PID             string `json:"pid"`
			Title           string `json:"title"`
			CallNumber      string `json:"callNumber,omitempty"`
			CatalogKey      string `json:"catalogKey,omitempty"`
			Creator         string `json:"creator,omitempty"`
			RightsURI       string `json:"rights"`
			RightsStatement string `json:"rightsStatement"`
			ExemplarURL     string `json:"exemplar"`
		}
		out := jsonOut{PID: resp.PID, Title: resp.Title, CallNumber: resp.CallNumber,
			CatalogKey: resp.CatalogKey, Creator: resp.CreatorName,
			RightsURI: svc.CNE.URI} // FIXME use a real vlue

		// exemplar is only required if an item is published. Many items will not have an exemplar set
		out.ExemplarURL, err = svc.getExemplarThumbURL(resp.ID)
		if err != nil {
			log.Printf("WARNING: brief metadata for %s is missing an exemplar: %s", pid, err)
		}
		rs := "Find more information about permission to use the library's materials at https://www.library.virginia.edu/policies/use-of-materials."
		out.RightsStatement = fmt.Sprintf("%s\n%s", svc.CNE.Statement, rs) // FIXME use real value
		log.Printf("INFO: successful request for brief metadata for %s", resp.PID)
		c.JSON(http.StatusOK, out)
		return
	}

	// Get MARC data for this item; only valid for Sirsi PIDs
	if mdType == "marc" {
		respBytes, err := svc.getMarc(resp)
		if err != nil {
			log.Printf("ERROR: Unable to get MARC for %s: %s", pid, err.Error())
			c.String(http.StatusInternalServerError, err.Error())
		} else {
			c.Header("Content-Type", "text/xml")
			c.String(http.StatusOK, string(respBytes))
		}
		return
	}

	// only used internally as part of the mods request. First part
	// of mods runs a transform on the marc to fix common problems.
	// the result is cached and used as the source for the marc->mods transform
	if mdType == "fixedmarc" {
		respBytes, err := svc.getFixedMARC(resp, clearCache)
		if err != nil {
			log.Printf("ERROR: Unable to get MARC for %s: %s", pid, err.Error())
			c.String(http.StatusInternalServerError, err.Error())
		} else {
			c.Header("Content-Type", "text/xml")
			c.String(http.StatusOK, string(respBytes))
		}

		return
	}

	// Get MODS metadata (from cache if available)
	if mdType == "mods" {
		xml, err := svc.getMODS(resp, clearCache)
		if err != nil {
			log.Printf("ERROR: unable to get MODS for %s: %s", pid, err.Error())
			c.String(http.StatusInternalServerError, err.Error())
			return
		}
		c.Header("Content-Type", "text/xml")
		c.String(http.StatusOK, string(xml))
		return
	}

	// Get uvaMAP metadata; this is a multistep process. First, a transform is applied to fix common
	// MARC errors. The result of that is transformed into MODS. Lastly, that MODS result is transformed
	// into uvaMAP. Each step of the transform is cached and used to drive the next step
	if mdType == "uvamap" {
		uvaMapBytes, err := svc.getUVAMAP(resp, clearCache)
		if err != nil {
			log.Printf("ERROR: unable to get uvaMAP for %s: %s", resp.PID, err.Error())
			c.String(http.StatusInternalServerError, err.Error())
			return
		}

		c.Header("Content-Type", "text/xml")
		c.String(http.StatusOK, string(uvaMapBytes))
		return
	}

	// Get DPLA metadata. This is another multi-step transform. Stages:
	// MARC -> FixedMARC -> MODS -> uvaMAP -> DPLA
	// As in other multi-step transforms, each step result is cached and drives the next step
	if mdType == "dpla" {
		dplaBytes, err := svc.getDPLA(resp, clearCache)
		if err != nil {
			log.Printf("ERROR: unable to get DPLA for %s: %s", resp.PID, err.Error())
			c.String(http.StatusInternalServerError, err.Error())
			return
		}

		c.Header("Content-Type", "text/xml")
		c.String(http.StatusOK, string(dplaBytes))
		return
	}

	log.Printf("ERROR: request for unsupported metadata type %s", mdType)
	c.String(http.StatusBadRequest, "invalid metadata type")
}

func (svc *ServiceContext) getMarc(md metadata) ([]byte, error) {
	log.Printf("INFO: Get MARC for %s", md.PID)
	marc := svc.getCache("marc", md.PID)
	if marc != nil {
		log.Printf("INFO: returning cached MARC")
		return marc, nil
	}

	log.Printf("INFO: Get MARC from Sirsi")
	url := ""
	if md.CatalogKey != "" {
		log.Printf("INFO: lookup sirsi metadata by catalog key [%s]", md.CatalogKey)
		re := regexp.MustCompile(`^u`)
		cKey := re.ReplaceAll([]byte(md.CatalogKey), []byte(""))
		url = fmt.Sprintf("%s/getMarc?ckey=%s&type=xml", svc.SirsiURL, cKey)
	} else {
		if md.Barcode != "" {
			log.Printf("INFO: lookup sirsi metadata by barcode [%s]", md.Barcode)
			url = fmt.Sprintf("%s/getMarc?barcode=%s&type=xml", svc.SirsiURL, md.Barcode)
		} else {
			return nil, fmt.Errorf("sirsi metadata %s has no barcode and no catalog key", md.PID)
		}
	}
	respStr, err := svc.getAPIResponse(url)
	if err != nil {
		return nil, err
	}

	log.Printf("INFO: Cache raw MARC for %s", md.PID)
	svc.updateCache("marc", md.PID, respStr)
	return respStr, nil
}

func (svc *ServiceContext) getFixedMARC(md metadata, clearCache bool) ([]byte, error) {
	fixedMarc := svc.getCache("fixedmarc", md.PID)
	if fixedMarc != nil {
		log.Printf("INFO: returning cached FixedMARC")
		return fixedMarc, nil
	}

	payload := url.Values{}
	payload.Set("source", fmt.Sprintf("%s/metadata/%s?type=marc", svc.APIURL, md.PID))
	payload.Set("style", fmt.Sprintf("%s/stylesheet/fixmarc", svc.APIURL))
	if clearCache {
		log.Printf("INFO: clearing saxon cache for fixedMARC")
		payload.Set("clear-stylesheet-cache", "yes")
	}

	log.Printf("INFO: run fixMarcErrors.xsl to cleanup metadata prior to transform to MODS on %s", md.PID)
	bodyBytes, err := svc.saxonTransform(&payload)
	if err != nil {
		log.Printf("WARNING: fixmarc failed with %s. Just transform original marc", err.Error())
		return svc.getMarc(md)
	}
	// Cache the fixed MARC in the MARC field of the data for this PID
	log.Printf("INFO: Cache fixedMARC for %s", md.PID)
	svc.updateCache("fixedmarc", md.PID, bodyBytes)
	return bodyBytes, nil
}

func (svc *ServiceContext) getMODS(md metadata, clearCache bool) ([]byte, error) {
	log.Printf("INFO: Get MODS for PID %s", md.PID)
	mods := svc.getCache("mods", md.PID)
	if mods != nil {
		log.Printf("INFO: returning cached MODS")
		return mods, nil
	}

	if md.Type == "SirsiMetadata" {
		log.Printf("INFO: Generating MODS for %s", md.PID)
		payload := url.Values{}
		payload.Set("source", fmt.Sprintf("%s/metadata/%s?type=fixedmarc", svc.APIURL, md.PID))
		payload.Set("style", fmt.Sprintf("%s/stylesheet/marctomods", svc.APIURL))
		if clearCache {
			log.Printf("INFO: clearing saxon cache for MARC->MODS")
			payload.Set("clear-stylesheet-cache", "yes")
		}
		payload.Set("barcode", md.Barcode)
		mods, err := svc.saxonTransform(&payload)
		if err == nil {
			log.Printf("INFO: cache MODS for %s", md.PID)
			svc.updateCache("mods", md.PID, mods)
		}
		return mods, err
	}

	if md.Type == "XmlMetadata" {
		log.Printf("INFO: Returning raw MODS from database for %s", md.PID)
		return []byte(md.DescMetadata), nil
	}

	return nil, fmt.Errorf("unsupported metadata type %s", md.Type)
}

func (svc *ServiceContext) getUVAMAP(md metadata, clearCache bool) ([]byte, error) {
	log.Printf("INFO: Get uvaMAP for PID %s", md.PID)
	uvaMAP := svc.getCache("uvamap", md.PID)
	if uvaMAP != nil {
		log.Printf("INFO: returning cached UVAMAP")
		return uvaMAP, nil
	}

	payload := url.Values{}
	payload.Set("source", fmt.Sprintf("%s/metadata/%s?type=mods", svc.APIURL, md.PID))
	payload.Set("style", fmt.Sprintf("%s/stylesheet/modstouvamap", svc.APIURL))

	payload.Set("PID", md.PID)
	payload.Set("tracksysMetaID", fmt.Sprintf("%d", md.ID))
	payload.Set("useRightsURI", "http://rightsstatements.org/vocab/CNE/1.0/") // FIUXME REMOVE THIS WHEN XSLT HAS BEEN UPDATED

	// notes: don't care about this error. the preview URI going away in the next rev
	// of the stylesheet and this code will no longer be needed
	uri, _ := svc.getExemplarThumbURL(md.ID)
	payload.Set("previewURI", uri)

	if clearCache {
		log.Printf("INFO: clearing saxon cache for MODS->uvaMAP")
		payload.Set("clear-stylesheet-cache", "yes")
	}

	uvaMapBytes, err := svc.saxonTransform(&payload)
	if err != nil {
		return nil, err
	}

	log.Printf("INFO: cache uvaMAP for %s", md.PID)
	svc.updateCache("uvamap", md.PID, uvaMapBytes)
	return uvaMapBytes, nil
}

func (svc *ServiceContext) getDPLA(md metadata, clearCache bool) ([]byte, error) {
	dpla := svc.getCache("dpla", md.PID)
	if dpla != nil {
		log.Printf("INFO: returning cached DPLA")
		return dpla, nil
	}
	payload := url.Values{}
	payload.Set("source", fmt.Sprintf("%s/metadata/%s?type=uvamap", svc.APIURL, md.PID))
	payload.Set("style", fmt.Sprintf("%s/stylesheet/uvamaptodpla", svc.APIURL))
	if clearCache {
		log.Printf("INFO: clearing saxon cache for uvaMAP->DPLA")
		payload.Set("clear-stylesheet-cache", "yes")
	}

	dplaBytes, err := svc.saxonTransform(&payload)
	if err != nil {
		return nil, err
	}

	log.Printf("INFO: cache DPLA for %s", md.PID)
	svc.updateCache("dpla", md.PID, dplaBytes)
	return dplaBytes, nil
}

func (svc *ServiceContext) getUseRightFromMARC(marcXML []byte) (*useRight, error) {
	log.Printf("INFO: extract use right from marc metadata")
	var marcUseRight useRight
	var parsed marcMetadata
	parseErr := xml.Unmarshal(marcXML, &parsed)
	if parseErr != nil {
		return nil, parseErr
	}

	if len(parsed.ControlFields) == 0 && len(parsed.DataFields) == 0 {
		return nil, fmt.Errorf("no matches found in sirsi")
	}

	useRightName := ""
	for _, df := range parsed.DataFields {
		if df.Tag == "856" {
			// use rights are held in 856 r (uri), t (name/statement), u (item uri)
			for _, sf := range df.Subfields {
				if sf.Code == "t" {
					useRightName = strings.TrimSpace(sf.Value)
					break
				}
			}
		}
	}

	if useRightName == "" {
		return nil, fmt.Errorf("no use right data found in MARC record")
	}

	log.Printf("INFO: lookup details for %s", useRightName)
	err := svc.GDB.Where("name=?", useRightName).First(&marcUseRight).Error
	if err != nil {
		return nil, err
	}

	return &marcUseRight, nil
}

func (svc *ServiceContext) getArchivesSpaceReport(c *gin.Context) {
	numDays, _ := strconv.Atoi(c.Query("days"))
	if numDays == 0 {
		log.Printf("ERROR: invalid archivesspace report; days param is zero or missing")
		c.String(http.StatusBadRequest, "non-zero days param is required")
		return
	}

	var asInfo externalSystem
	err := svc.GDB.Where("name=?", "ArchivesSpace").First(&asInfo).Error
	if err != nil {
		log.Printf("ERROR: unable to get archivesspace system info: %s", err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}

	log.Printf("INFO: get report of archivesspace addditions in the last %d days", numDays)
	negDays := numDays * -1
	minDate := time.Now().AddDate(0, 0, negDays)
	var asRecs []metadata
	err = svc.GDB.Where("external_system_id=? and external_uri != ? and created_at > ?", asInfo.ID, "", minDate).
		Order("created_at desc").Find(&asRecs).Error
	if err != nil {
		log.Printf("ERROR: unable to get archivesspace report: %s", err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}

	c.Header("Content-Type", "text/csv")
	cw := csv.NewWriter(c.Writer)
	csvHead := []string{"pid", "title", "date", "archivesspace_url", "tracksys_url"}
	cw.Write(csvHead)
	for _, as := range asRecs {
		line := []string{
			as.PID,
			as.Title,
			as.CreatedAt.Format("2006-01-02"),
			fmt.Sprintf("%s%s", asInfo.PublicURL, as.ExternalURI),
			fmt.Sprintf("%s/metadata/%d", svc.TrackSysURL, as.ID),
		}
		cw.Write(line)
	}

	cw.Flush()
}
