package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
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

	log.Printf("Search tracksys for %s", queryTxt)
	sql := fmt.Sprintf(`select id,pid,type,title,barcode,call_number from metadata
			where title like {:qany} or barcode like {:q} or pid like {:q} or call_number like {:q} limit 500`)
	q := svc.DB.NewQuery(sql)
	q.Bind(dbx.Params{"qany": fmt.Sprintf("%%%s%%", queryTxt), "q": fmt.Sprintf("%s%%", queryTxt)})
	var mdResp []metadataSummary
	err := q.All(&mdResp)
	if err != nil {
		log.Printf("Search failed: %s", err.Error())
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
	log.Printf("Get %s metadata for %s", mdType, pid)

	// first, see if it is a masterfile pid and pull the metadata pid...
	qSQL := `select m.pid from master_files f left outer join metadata m
		on m.id = f.metadata_id where f.pid={:pid}`
	q := svc.DB.NewQuery(qSQL)
	q.Bind(dbx.Params{"pid": pid})
	var newPID string
	err := q.Row(&newPID)
	if err == nil {
		log.Printf("%s is a master file. Metadata PID=%s", pid, newPID)
		pid = newPID
	}

	// Now get metadata details
	qSQL = `select m.id,pid,type,title,call_number,catalog_key,creator_name,
		u.uri as rights_uri, u.statement as rights from metadata m
		left outer join use_rights u on u.id = m.use_right_id
		where pid={:pid}`
	q = svc.DB.NewQuery(qSQL)
	q.Bind(dbx.Params{"pid": pid})
	var resp struct {
		ID         int64          `db:"id"`
		PID        string         `db:"pid"`
		Type       string         `db:"type"`
		Title      string         `db:"title"`
		CallNumber sql.NullString `db:"call_number"`
		CatalogKey sql.NullString `db:"catalog_key"`
		Creator    sql.NullString `db:"creator_name"`
		RightsURI  string         `db:"rights_uri"`
		Rights     string         `db:"rights"`
	}
	err = q.One(&resp)
	if err != nil {
		log.Printf("ERROR: %s not found: %s", pid, err.Error())
		c.String(http.StatusNotFound, "not found")
		return
	}

	if mdType == "marc" || mdType == "fixedmarc" {
		if resp.CatalogKey.Valid {
			re := regexp.MustCompile(`^u`)
			cKey := re.ReplaceAll([]byte(resp.CatalogKey.String), []byte(""))
			url := fmt.Sprintf("%s/getMarc?ckey=%s&type=xml", svc.SirsiURL, cKey)
			respStr, err := svc.getAPIResponse(url)
			if err != nil {
				c.String(http.StatusNotFound, err.Error())
			} else {
				c.Header("Content-Type", "text/xml")
				c.String(http.StatusOK, string(respStr))
			}
		} else {
			c.String(http.StatusNotFound, "not found")
		}
		return
	}

	exemplarURL := svc.getExemplarThumbURL(resp.ID)

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
		out.ExemplarURL = exemplarURL
		rs := "Find more information about permission to use the library's materials at https://www.library.virginia.edu/policies/use-of-materials."
		out.RightsStatement = fmt.Sprintf("%s\n%s", resp.Rights, rs)
		c.JSON(http.StatusOK, out)
		return
	}

	if mdType == "mods" {
		c.String(http.StatusOK, "mods")
		return
	}

	c.String(http.StatusBadRequest, "invalid metadata type")
}
