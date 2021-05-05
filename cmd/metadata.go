package main

import (
	"database/sql"
	"errors"
	"fmt"
	"log"
	"net/http"
	"net/url"
	"regexp"

	"github.com/gin-gonic/gin"
	dbx "github.com/go-ozzo/ozzo-dbx"
)

type metadata struct {
	ID           int64          `db:"id"`
	PID          string         `db:"pid"`
	Type         string         `db:"type"`
	Title        string         `db:"title"`
	Barcode      sql.NullString `db:"barcode"`
	CallNumber   sql.NullString `db:"call_number"`
	CatalogKey   sql.NullString `db:"catalog_key"`
	Creator      sql.NullString `db:"creator_name"`
	RightsURI    string         `db:"rights_uri"`
	Rights       string         `db:"rights"`
	DescMetadata sql.NullString `db:"desc_metadata"`
}

func (svc *ServiceContext) searchMetadata(c *gin.Context) {
	queryTxt := c.Query("q")
	if queryTxt == "" {
		log.Printf("ERROR: search requested with no query")
		c.String(http.StatusBadRequest, "q parameter required")
		return
	}

	log.Printf("INFO: search tracksys for %s", queryTxt)
	sql := fmt.Sprintf(`select id,pid,type,title,barcode,call_number from metadata
			where title like {:qany} or barcode like {:q} or pid like {:q} or call_number like {:q} limit 500`)
	q := svc.DB.NewQuery(sql)
	q.Bind(dbx.Params{"qany": fmt.Sprintf("%%%s%%", queryTxt), "q": fmt.Sprintf("%s%%", queryTxt)})
	var mdResp []metadataSummary
	err := q.All(&mdResp)
	if err != nil {
		log.Printf("WARNING: search failed: %s", err.Error())
		c.String(http.StatusNotFound, "not found")
		return
	}

	type hitData struct {
		ID         int64  `json:"id"`
		PID        string `json:"pid"`
		Type       string `json:"type"`
		Title      string `json:"title"`
		Barcode    string `json:"barcode,omitempty"`
		CallNumber string `json:"call_number,omitempty"`
	}
	out := make([]hitData, 0)
	for _, md := range mdResp {
		hit := hitData{ID: md.ID, PID: md.PID, Type: md.Type, Title: md.Title,
			Barcode: md.Barcode.String, CallNumber: md.CallNumber.String}
		out = append(out, hit)
	}

	log.Printf("%d hits found for %s", len(out), queryTxt)
	c.JSON(http.StatusOK, out)
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
	qSQL := `select m.pid from master_files f left outer join metadata m
		on m.id = f.metadata_id where f.pid={:pid}`
	q := svc.DB.NewQuery(qSQL)
	q.Bind(dbx.Params{"pid": pid})
	var newPID string
	err := q.Row(&newPID)
	if err == nil {
		log.Printf("INFO: %s is a master file. Metadata PID=%s", pid, newPID)
		pid = newPID
	} else if err != sql.ErrNoRows {
		log.Printf("ERROR: unable to find masterfile %s: %s", pid, err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}

	// Now get metadata details
	qSQL = `select m.id,pid,type,title,call_number,catalog_key,creator_name,
		barcode, desc_metadata, u.uri as rights_uri, u.statement as rights from metadata m
		left outer join use_rights u on u.id = m.use_right_id
		where pid={:pid}`
	q = svc.DB.NewQuery(qSQL)
	q.Bind(dbx.Params{"pid": pid})
	var resp metadata
	err = q.One(&resp)
	if err != nil {
		if err != sql.ErrNoRows {
			log.Printf("ERROR: %s not found: %s", pid, err.Error())
			c.String(http.StatusInternalServerError, err.Error())
		} else {
			log.Printf("WARNING: %s not found", pid)
			c.String(http.StatusNotFound, "not found")
		}
		return
	}

	// Simple request for brief metadata on this item
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
		out := jsonOut{PID: resp.PID, Title: resp.Title, CallNumber: resp.CallNumber.String,
			CatalogKey: resp.CatalogKey.String, Creator: resp.Creator.String, RightsURI: resp.RightsURI}
		out.ExemplarURL = svc.getExemplarThumbURL(resp.ID)
		rs := "Find more information about permission to use the library's materials at https://www.library.virginia.edu/policies/use-of-materials."
		out.RightsStatement = fmt.Sprintf("%s\n%s", resp.Rights, rs)
		log.Printf("INFO: successful request for brief metadata for %s", resp.PID)
		c.JSON(http.StatusOK, out)
		return
	}

	// Get MARC data for this item; only valid for Sirsi PIDs
	if mdType == "marc" {
		respBytes, err := svc.getMarc(resp)
		if err != nil {
			log.Printf("WARNING: Unable to get MARC for %s: %s", pid, err.Error())
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
			log.Printf("WARNING: Unable to get MARC for %s: %s", pid, err.Error())
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
			log.Printf("WARNING: unable to get MODS for %s: %s", pid, err.Error())
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
			log.Printf("WARNING: unable to get uvaMAP for %s: %s", resp.PID, err.Error())
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
			log.Printf("WARNING: unable to get DPLA for %s: %s", resp.PID, err.Error())
			c.String(http.StatusInternalServerError, err.Error())
			return
		}

		c.Header("Content-Type", "text/xml")
		c.String(http.StatusOK, string(dplaBytes))
		return
	}

	c.String(http.StatusBadRequest, "invalid metadata type")
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
			payload.Set("clear-stylesheet-cache", "yes")
		}
		payload.Set("PID", md.PID)
		payload.Set("tracksysMetaID", fmt.Sprintf("%d", md.ID))
		payload.Set("previewURI", svc.getExemplarThumbURL(md.ID))
		payload.Set("useRightsURI", md.RightsURI)
		payload.Set("barcode", md.Barcode.String)
		mods, err := svc.saxonTransform(&payload)
		if err == nil {
			log.Printf("INFO: cache MODS for %s", md.PID)
			svc.updateCache("mods", md.PID, mods)
		}
		return mods, err
	}

	if md.Type == "XmlMetadata" {
		log.Printf("INFO: Returning raw MODS from database for %s", md.PID)
		return []byte(md.DescMetadata.String), nil
	}

	log.Printf("WARNING: MODS metadata requested for unsupported metadata type: %s", md.Type)
	return nil, errors.New("not found")
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
	if clearCache {
		payload.Set("clear-stylesheet-cache", "yes")
	}

	uvaMapBytes, err := svc.saxonTransform(&payload)
	if err != nil {
		log.Printf("ERROR: modstouvamap for %s failed with %s.", md.PID, err.Error())
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
		payload.Set("clear-stylesheet-cache", "yes")
	}

	dplaBytes, err := svc.saxonTransform(&payload)
	if err != nil {
		log.Printf("ERROR: uvamaptodpla for %s failed with %s.", md.PID, err.Error())
		return nil, err
	}

	log.Printf("INFO: cache DPLA for %s", md.PID)
	svc.updateCache("dpla", md.PID, dplaBytes)
	return dplaBytes, nil
}

func (svc *ServiceContext) getMarc(md metadata) ([]byte, error) {
	log.Printf("INFO: Get MARC for %s", md.PID)
	marc := svc.getCache("marc", md.PID)
	if marc != nil {
		log.Printf("INFO: returning cached MARC")
		return marc, nil
	}

	log.Printf("INFO: Get MARC from Sirsi")
	re := regexp.MustCompile(`^u`)
	cKey := re.ReplaceAll([]byte(md.CatalogKey.String), []byte(""))
	url := fmt.Sprintf("%s/getMarc?ckey=%s&type=xml", svc.SirsiURL, cKey)
	respStr, err := svc.getAPIResponse(url)
	if err != nil {
		return nil, err
	}

	log.Printf("INFO: Cache raw MARC for %s", md.PID)
	svc.updateCache("marc", md.PID, respStr)
	return respStr, nil
}
