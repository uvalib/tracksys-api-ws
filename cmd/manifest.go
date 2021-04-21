package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	dbx "github.com/go-ozzo/ozzo-dbx"
)

type masterFileData struct {
	ID           int64          `db:"id"`
	PID          string         `db:"pid"`
	Filename     string         `db:"filename"`
	Width        int            `db:"width"`
	Height       int            `db:"height"`
	Title        sql.NullString `db:"title"`
	Description  sql.NullString `db:"description"`
	TextSource   sql.NullString `db:"text_source"`
	Orientation  int            `db:"orientation"`
	ClonedFromID sql.NullInt64  `db:"original_mf_id"`
}

type manifestData struct {
	ID          int64      `json:"id"`
	PID         string     `json:"pid"`
	Filename    string     `json:"filename"`
	Width       int        `json:"width"`
	Height      int        `json:"height"`
	Title       string     `json:"title,omitempty"`
	Description string     `json:"description,omitempty"`
	TextSource  string     `json:"text_source,omitempty"`
	Orientation string     `json:"orientation"`
	ClonedFrom  *cloneData `json:"cloned_from,omitempty"`
}

func (svc *ServiceContext) getManifest(c *gin.Context) {
	pid := c.Param("pid")
	q := svc.DB.NewQuery("select id from metadata where pid={:pid} and date_dl_ingest is not null")
	q.Bind(dbx.Params{"pid": pid})
	var tgtID int64
	err := q.Row(&tgtID)
	if err != nil {
		log.Printf("WARNING: %s is not metadata: %s", pid, err.Error())
		q := svc.DB.NewQuery("select id from components where pid={:pid} and date_dl_ingest is not null")
		q.Bind(dbx.Params{"pid": pid})
		err := q.Row(&tgtID)
		if err != nil {
			log.Printf("WARNING: %s is not a component: %s", pid, err.Error())
			c.String(http.StatusNotFound, fmt.Sprintf("%s not found", pid))
			return
		}

		manifest, err := svc.getComponentManifest(tgtID)
		if err != nil {
			log.Printf("ERROR: Unable to get component %d manifest: %s", tgtID, err.Error())
			c.String(http.StatusNotFound, fmt.Sprintf("%s not found", pid))
		} else {
			c.JSON(http.StatusOK, manifest)
		}
		return
	}

	unitID := c.Query("unit")
	manifest, err := svc.getMetadataManifest(tgtID, unitID)
	if err != nil {
		log.Printf("ERROR: Unable to get metadata %s manifest: %s", pid, err.Error())
		c.String(http.StatusNotFound, fmt.Sprintf("%s not found", pid))
	} else {
		c.JSON(http.StatusOK, manifest)
	}
}

func (svc *ServiceContext) getComponentManifest(cID int64) (*[]manifestData, error) {
	sql := `select m.id,pid,filename,title,description,exemplar,text_source,original_mf_id,
		width,height,orientation from master_files m
		inner join image_tech_meta t on t.master_file_id = m.id
		where component_id={:cid}`
	q := svc.DB.NewQuery(sql)
	q.Bind(dbx.Params{"cid": cID})

	var masterFiles []masterFileData
	err := q.All(&masterFiles)
	if err != nil {
		return nil, err
	}

	return svc.generateManifest(&masterFiles)
}

func (svc *ServiceContext) getMetadataManifest(ID int64, unitID string) (*[]manifestData, error) {
	var out []masterFileData
	sql := `select m.id,pid,filename,title,description,exemplar,text_source,original_mf_id,
		width,height,orientation from master_files m `
	var q *dbx.Query

	if unitID != "" {
		log.Printf("INFO: only including masterfiles from unit %s", unitID)
		sql += ` inner join image_tech_meta t on t.master_file_id = m.id
			where metadata_id={:mid} and unit_id={:uid} order by filename asc`
		q = svc.DB.NewQuery(sql)
		q.Bind(dbx.Params{"mid": ID, "uid": unitID})
	} else {
		log.Printf("INFO: only including masterfiles from units in the DL")
		sql += ` inner join units u on u.id = m.unit_id
				inner join image_tech_meta t on t.master_file_id = m.id
				where m.metadata_id={:mid} and u.include_in_dl = 1 order by filename asc`
		q = svc.DB.NewQuery(sql)
		q.Bind(dbx.Params{"mid": ID})
	}

	err := q.All(&out)
	if err != nil {
		return nil, err
	}

	return svc.generateManifest(&out)
}

func (svc *ServiceContext) generateManifest(masterFiles *[]masterFileData) (*[]manifestData, error) {
	// take raw master file data and convert into the manifest, including orientation and clone info
	orientations := []string{"normal", "flip_y_axis", "rotate90", "rotate180", "rotate270"}
	out := make([]manifestData, 0)
	for _, mf := range *masterFiles {
		item := manifestData{ID: mf.ID, PID: mf.PID, Filename: mf.Filename,
			Title: mf.Title.String, Description: mf.Description.String, TextSource: mf.TextSource.String,
			Width: mf.Width, Height: mf.Height, Orientation: "normal"}

		// convert rails enum to string
		item.Orientation = orientations[mf.Orientation]

		// get original info if this is a clone
		if mf.ClonedFromID.Valid {
			orig, err := svc.getOriginalMasterFile(mf.ClonedFromID.Int64)
			if err != nil {
				return nil, err
			}
			item.ClonedFrom = orig
		}

		out = append(out, item)
	}
	return &out, nil
}
