package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	dbx "github.com/go-ozzo/ozzo-dbx"
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

type basicMetadata struct {
	ID              int64   `db:"id"`
	PID             string  `db:"pid"`
	CollectionFacet *string `db:"collection_facet"`
	RightsURI       string  `db:"uri"`
	Educational     bool    `db:"educational_use"`
	Commercial      bool    `db:"commercial_use"`
	Modification    bool    `db:"modifications"`
	CallNumber      string  `db:"call_number"`
	Barcode         string  `db:"barcode"`
}

func (svc *ServiceContext) getEnrichedOtherMetadata(c *gin.Context) {
	key := c.Param("pid")
	log.Printf("Get enriched other metadata for PID %s", key)
	sql := `select m.id, pid, collection_facet, educational_use, commercial_use, modifications, uri
		from metadata m left outer join use_rights u on u.id = m.use_right_id where pid={:id}
		and date_dl_ingest is not null`
	q := svc.DB.NewQuery(sql)
	q.Bind(dbx.Params{"id": key})
	var md basicMetadata
	err := q.One(&md)
	if err != nil {
		log.Printf("%s not found: %s", key, err.Error())
		c.String(http.StatusNotFound, fmt.Sprintf("%s not found", key))
		return
	}
	var out struct {
		PDF string `json:"pdfServiceRoot"`
		enrichData
	}
	out.PID = md.PID
	out.PDF = svc.PDFServiceURL
	out.Uses = getUses(&md)
	out.ExemplarURL = svc.getExemplarThumb(md.ID)
	if md.CollectionFacet != nil {
		out.Collection = *md.CollectionFacet
	}
	out.IIIFManURL = fmt.Sprintf("%s/pid/%s", svc.IIIFManURL, md.PID)
	out.UseURI = md.RightsURI

	c.JSON(http.StatusOK, out)
}

func (svc *ServiceContext) getEnrichedSirsiMetadata(c *gin.Context) {
	key := c.Param("key")
	log.Printf("Get enriched sirsi metadata for catalog key %s", key)
	sql := `select m.id, pid, collection_facet, barcode, call_number,
		educational_use, commercial_use, modifications, uri
		from metadata m left outer join use_rights u on u.id = m.use_right_id where catalog_key={:id}
		and date_dl_ingest is not null order by call_number asc`
	q := svc.DB.NewQuery(sql)
	q.Bind(dbx.Params{"id": key})
	var mdRecs []basicMetadata
	err := q.All(&mdRecs)
	if err != nil {
		log.Printf("%s not found: %s", key, err.Error())
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
		item := enrichData{PID: md.PID, CallNumber: md.CallNumber, Barcode: md.Barcode, UseURI: md.RightsURI}
		item.IIIFManURL = fmt.Sprintf("%s/pid/%s", svc.IIIFManURL, md.PID)
		item.ExemplarURL = svc.getExemplarThumb(md.ID)
		item.Uses = getUses(&md)
		out.Items = append(out.Items, item)
	}

	c.JSON(http.StatusOK, out)
}

func (svc *ServiceContext) getExemplarThumb(mdID int64) string {
	exemplarURL := ""
	sql := `select id,pid,original_mf_id from master_files where metadata_id={:id} and exemplar=1 limit 1`
	q := svc.DB.NewQuery(sql)
	q.Bind(dbx.Params{"id": mdID})

	var mf struct {
		ID           int64  `db:"id"`
		PID          string `db:"pid"`
		ClonedFromID *int64 `db:"original_mf_id"`
	}
	err := q.One(&mf)
	if err != nil {
		log.Printf("Unable to find exemplar for %d: %s", mdID, err.Error())
		return exemplarURL
	}

	// If ClonedFromID is set, this MF is cloned. Must use original MF for exemplar
	if mf.ClonedFromID != nil {
		q := svc.DB.NewQuery(sql)
		q.Bind(dbx.Params{"id": mf.ClonedFromID})
		err := q.One(&mf)
		if err != nil {
			log.Printf("Unable to find original exemplar for %d: %s", mdID, err.Error())
			return exemplarURL
		}
	}

	// orientation is enum type: none: 0, flip_y_axis: 1, rotate90: 2, rotate180: 3, rotate270
	sql = `select orientation from image_tech_meta where master_file_id={:id} limit 1`
	q = svc.DB.NewQuery(sql)
	orientationID := 0
	rotations := []string{"0", "!0", "90", "180", "270"}
	q.Bind(dbx.Params{"id": mf.ID})
	q.Row(&orientationID)
	exemplarURL = fmt.Sprintf("%s/%s/full/!125,200/%s/default.jpg", svc.IIIFURL, mf.PID, rotations[orientationID])

	return exemplarURL
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
