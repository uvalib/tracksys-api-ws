package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"net/url"
	"regexp"

	"github.com/gin-gonic/gin"
	dbx "github.com/go-ozzo/ozzo-dbx"
)

func (svc *ServiceContext) searchMetadata(c *gin.Context) {
	queryTxt := c.Query("q")
	if queryTxt == "" {
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

	c.JSON(http.StatusOK, out)
}

func (svc *ServiceContext) getMetadata(c *gin.Context) {
	pid := c.Param("pid")
	mdType := c.Query("type")
	if mdType == "" {
		c.String(http.StatusBadRequest, "type is required")
		return
	}
	log.Printf("INFO: get %s metadata for %s", mdType, pid)

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
	}

	// Now get metadata details
	qSQL = `select m.id,pid,type,title,call_number,catalog_key,creator_name,
		barcode, desc_metadata, u.uri as rights_uri, u.statement as rights from metadata m
		left outer join use_rights u on u.id = m.use_right_id
		where pid={:pid}`
	q = svc.DB.NewQuery(qSQL)
	q.Bind(dbx.Params{"pid": pid})
	var resp struct {
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
	err = q.One(&resp)
	if err != nil {
		log.Printf("ERROR: %s not found: %s", pid, err.Error())
		c.String(http.StatusNotFound, "not found")
		return
	}

	if mdType == "marc" {
		respBytes, err := svc.getMarc(resp.CatalogKey.String)
		if err != nil {
			log.Printf("ERROR: Unable to get MARC for %s: %s", pid, err.Error())
			c.String(http.StatusNotFound, ":not found")
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
		out, ok := svc.Cache[pid]
		if ok {
			c.Header("Content-Type", "text/xml")
			c.String(http.StatusOK, string(*out))
			delete(svc.Cache, pid)
		} else {
			log.Printf("INFO: fixed MARC not available for %s, just use MARC", pid)
			respBytes, err := svc.getMarc(resp.CatalogKey.String)
			if err != nil {
				log.Printf("ERROR: Unable to get MARC for %s: %s", pid, err.Error())
				c.String(http.StatusNotFound, ":not found")
			} else {
				c.Header("Content-Type", "text/xml")
				c.String(http.StatusOK, string(respBytes))
			}
		}
		return
	}

	if mdType == "mods" {
		if resp.Type == "SirsiMetadata" {
			xml, err := svc.convertMarcToMods(resp.PID, resp.Barcode.String)
			if err != nil {
				log.Printf("ERROR: unable to transform marc into mods: %s", err.Error())
				c.String(http.StatusInternalServerError, err.Error())
				return
			}
			c.Header("Content-Type", "text/xml")
			c.String(http.StatusOK, string(xml))
			return
		}

		if resp.Type == "XmlMetadata" {
			if resp.DescMetadata.Valid {
				c.Header("Content-Type", "text/xml")
				c.String(http.StatusOK, resp.DescMetadata.String)
			} else {
				c.String(http.StatusNotFound, "not found")
			}
			return
		}

		c.String(http.StatusBadRequest, fmt.Sprintf("invalid metadata type for mods %s", resp.Type))
		return
	}

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
		c.JSON(http.StatusOK, out)
		return
	}

	c.String(http.StatusBadRequest, "invalid metadata type")
}

func (svc *ServiceContext) getMarc(catKey string) ([]byte, error) {
	re := regexp.MustCompile(`^u`)
	cKey := re.ReplaceAll([]byte(catKey), []byte(""))
	url := fmt.Sprintf("%s/getMarc?ckey=%s&type=xml", svc.SirsiURL, cKey)
	respStr, err := svc.getAPIResponse(url)
	if err != nil {
		return nil, err
	}
	return respStr, nil
}

func (svc *ServiceContext) convertMarcToMods(PID string, barcode string) ([]byte, error) {
	// Converstion is two steps; first transform to fix common marc errors:
	log.Printf("INFO: run fixMarcErrors.xsl to cleanup metadata prior to transform to MODS on %s", PID)
	payload := url.Values{}
	payload.Set("source", fmt.Sprintf("%s/metadata/%s?type=marc", svc.APIURL, PID))
	payload.Set("style", fmt.Sprintf("%s/stylesheet/fixmarc", svc.APIURL))
	payload.Set("clear-stylesheet-cache", "yes")

	bodyBytes, err := svc.saxonTransform(&payload)
	if err != nil {
		log.Printf("ERROR: fixmarc failed with %s. Just transform original marc", err.Error())
	} else {
		svc.Cache[PID] = &bodyBytes
		payload.Set("source", fmt.Sprintf("%s/metadata/%s?type=fixedmarc", svc.APIURL, PID))
	}

	// second step is to convert the fixed MARC to MODS
	payload.Set("barcode", barcode)
	payload.Set("style", fmt.Sprintf("%s/stylesheet/marctomods", svc.APIURL))
	return svc.saxonTransform(&payload)
}
