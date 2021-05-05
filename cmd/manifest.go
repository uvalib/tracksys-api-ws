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

	// First see if the PID is for a metadata record...
	log.Printf("INFO: get manifest for %s", pid)
	q := svc.DB.NewQuery("select id from metadata where pid={:pid}")
	q.Bind(dbx.Params{"pid": pid})
	var tgtID int64
	err := q.Row(&tgtID)
	if err == nil {
		log.Printf("INFO: %s is a metadata record", pid)
		unitID := c.Query("unit")
		manifest, err := svc.getMetadataManifest(tgtID, unitID)
		if err != nil {
			log.Printf("ERROR: Unable to get manifest for metadata %s: %s", pid, err.Error())
			c.String(http.StatusInternalServerError, err.Error())
		} else {
			c.JSON(http.StatusOK, manifest)
		}
		return
	} else if err != sql.ErrNoRows {
		log.Printf("ERROR: manifest query to find metadata %s failed: %s", pid, err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}

	// See if the pid is a component...
	log.Printf("INFO: %s is not a metadata record; trying components", pid)
	q = svc.DB.NewQuery("select id from components where pid={:pid}")
	q.Bind(dbx.Params{"pid": pid})
	err = q.Row(&tgtID)
	if err == nil {
		log.Printf("INFO: %s is a component", pid)
		manifest, err := svc.getComponentManifest(tgtID)
		if err != nil {
			log.Printf("ERROR: Unable to get manifest for component %d: %s", tgtID, err.Error())
			c.String(http.StatusInternalServerError, err.Error())
		} else {
			c.JSON(http.StatusOK, manifest)
		}
		return
	} else if err != sql.ErrNoRows {
		log.Printf("ERROR: manifest query to find compponent %s failed: %s", pid, err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}

	log.Printf("WARNING: %s not found in database", pid)
	c.String(http.StatusNotFound, fmt.Sprintf("%s not found", pid))
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
			where unit_id={:uid} order by filename asc`
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
	if len(*masterFiles) == 0 {
		return nil, fmt.Errorf("no masterfiles found")
	}
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
			log.Printf("INFO: lookup original masterfile %d for clone", mf.ClonedFromID.Int64)
			q := svc.DB.NewQuery("select id,pid,filename from master_files where id={:id}")
			q.Bind(dbx.Params{"id": mf.ClonedFromID.Int64})
			var clonedFrom cloneData
			err := q.One(&clonedFrom)
			if err != nil {
				return nil, fmt.Errorf("master file %d is cloned from %d, but original could not be found: %s",
					mf.ID, mf.ClonedFromID.Int64, err.Error())
			}
			item.ClonedFrom = &clonedFrom
		}

		out = append(out, item)
	}
	log.Printf("INFO: generated manifest with %d master files", len(out))
	return &out, nil
}
