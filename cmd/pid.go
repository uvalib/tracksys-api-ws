package main

import (
	"database/sql"
	"log"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
	dbx "github.com/go-ozzo/ozzo-dbx"
)

type metadataSummary struct {
	ID            int64          `db:"id"`
	Type          string         `db:"type"`
	Title         string         `db:"title"`
	AvailbilityID sql.NullInt64  `db:"availability_policy_id"`
	OCRLangHint   sql.NullString `db:"ocr_language_hint"`
	OCRHint       sql.NullString `db:"ocr_hint"`
	OCRCandidate  sql.NullBool   `db:"ocr_candidate"`
}

type masterFileSummary struct {
	ID         int64          `db:"id"`
	Title      sql.NullString `db:"title"`
	Filename   sql.NullString `db:"filename"`
	TextSource sql.NullString `db:"text_source"`
	UnitID     int64          `db:"unit_id"`
}

type componentSummary struct {
	ID    int64          `db:"id"`
	Title sql.NullString `db:"title"`
}

type ocrSummary struct {
	OCRHint          string `json:"ocr_hint,omitempty"`
	OCRLanguageHint  string `json:"ocr_language_hint,omitempty"`
	OCRCandidate     bool   `json:"ocr_candidate,omitempty"`
	HasOCR           bool   `json:"has_ocr,omitempty"`
	HasTranscription bool   `json:"has_transcription,omitempty"`
}

type pidSummary struct {
	ID         int64      `json:"id"`
	PID        string     `json:"pid"`
	Type       string     `json:"type"`
	Title      string     `json:"title,omitempty"`
	Filename   string     `json:"filename,omitempty"`
	ParentPID  string     `json:"parent_metadata_pid,omitempty"`
	TextSource string     `json:"text_source,omitempty"`
	ClonedFrom *cloneData `json:"cloned_from,omitempty"`
	*ocrSummary
}

func (svc *ServiceContext) getPIDSummary(c *gin.Context) {
	pid := c.Param("pid")
	log.Printf("Get summary for %s", pid)

	// First try metadata...
	sql := `select m.id,type,title,availability_policy_id,ocr_language_hint,o.name as ocr_hint,ocr_candidate
		from metadata m left outer join ocr_hints o on o.id = m.ocr_hint_id where pid={:pid}`
	q := svc.DB.NewQuery(sql)
	q.Bind(dbx.Params{"pid": pid})
	var mdResp metadataSummary
	err := q.One(&mdResp)
	if err == nil {
		log.Printf("METADATA: %+v", mdResp)
		return
	}

	// try master file...
	sql = `select id,title,filename,text_source,unit_id from master_files where pid={:pid}`
	q = svc.DB.NewQuery(sql)
	q.Bind(dbx.Params{"pid": pid})
	var mfResp masterFileSummary
	err = q.One(&mfResp)
	if err == nil {
		log.Printf("MASTEFILE: %+v", mfResp)
		return
	}

	// try component...
	q = svc.DB.NewQuery("select id,title from components where pid={:pid}")
	q.Bind(dbx.Params{"pid": pid})
	var cResp componentSummary
	err = q.One(&cResp)
	if err == nil {
		out := pidSummary{ID: cResp.ID, PID: pid, Title: cResp.Title.String}
		c.JSON(http.StatusOK, out)
		return
	}

	c.String(http.StatusNotFound, "not found")
}

func (svc *ServiceContext) getPIDText(c *gin.Context) {
	pid := c.Param("pid")
	log.Printf("Get full text for %s", pid)
	c.String(http.StatusNotImplemented, "not yet")
}

func (svc *ServiceContext) getPIDType(c *gin.Context) {
	pid := c.Param("pid")
	log.Printf("Get type for %s", pid)

	// First try metadata
	qSQL := `select type,e.name as ext_system from metadata m left outer join external_systems e
		on e.id = m.external_system_id where pid={:pid}`
	q := svc.DB.NewQuery(qSQL)
	q.Bind(dbx.Params{"pid": pid})
	var resp struct {
		Type   string         `db:"type"`
		System sql.NullString `db:"ext_system"`
	}
	err := q.One(&resp)
	if err == nil {
		if resp.Type == "SirsiMetadata" {
			c.String(http.StatusOK, "sirsi_metadata")
		} else if resp.Type == "XmlMetadata" {
			c.String(http.StatusOK, "xml_metadata")
		} else if resp.Type == "ExternalMetadata" && resp.System.String == "ArchivesSpace" {
			c.String(http.StatusOK, "archivesspace_metadata")
		} else if resp.Type == "ExternalMetadata" && resp.System.String == "Apollo" {
			c.String(http.StatusOK, "apollo_metadata")
		} else if resp.Type == "ExternalMetadata" && resp.System.String == "JSTOR Forum" {
			c.String(http.StatusOK, "jstor_metadata")
		} else {
			c.String(http.StatusInternalServerError, "unknown metadata type")
		}
		return
	}

	// see if it is a component...
	var ID uint64
	q = svc.DB.NewQuery(`select id from components where pid={:pid}`)
	q.Bind(dbx.Params{"pid": pid})
	err = q.Row(&ID)
	if err == nil {
		c.String(http.StatusOK, "component")
		return
	}

	// last chance... master file?
	q = svc.DB.NewQuery(`select id from master_files where pid={:pid}`)
	q.Bind(dbx.Params{"pid": pid})
	err = q.Row(&ID)
	if err == nil {
		c.String(http.StatusOK, "masterfile")
		return
	}

	log.Printf("ERROR: unable to find PID %s: %s", pid, err.Error())
	c.String(http.StatusNotFound, "not found")
}

func (svc *ServiceContext) getPIDRights(c *gin.Context) {
	pid := c.Param("pid")
	log.Printf("Get rights for %s", pid)
	q := svc.DB.NewQuery(`select id,availability_policy_id from metadata where pid={:pid}`)
	q.Bind(dbx.Params{"pid": pid})
	var resp struct {
		ID      int64  `db:"id"`
		AvailID *int64 `db:"availability_policy_id"`
	}
	err := q.One(&resp)
	if err != nil {
		sql := `select f.id,availability_policy_id from master_files f
			inner join metadata m on m.id = f.metadata_id
			inner join availability_policies a on a.id = m.availability_policy_id
			where f.pid={:pid}`
		q = svc.DB.NewQuery(sql)
		q.Bind(dbx.Params{"pid": pid})
		err = q.One(&resp)
		if err != nil {
			log.Printf("Unable to find %s: %s", pid, err.Error())
			c.String(http.StatusNotFound, "not found")
			return
		}
	}

	if resp.AvailID == nil {
		c.String(http.StatusOK, "private")
		return
	}
	q = svc.DB.NewQuery("select name from availability_policies where id={:id}")
	q.Bind(dbx.Params{"id": resp.AvailID})
	var rights string
	err = q.Row(&rights)
	if err == nil {
		c.String(http.StatusOK, strings.ToLower(strings.Split(rights, " ")[0]))
		return
	}

	c.String(http.StatusNotFound, "not found")
}
