package main

import (
	"fmt"
	"log"
	"net/http"

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
	c.String(http.StatusNotImplemented, "not yet")
}
