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
	ID           int64          `db:"id"`
	PID          string         `db:"pid"`
	Type         string         `db:"type"`
	Title        string         `db:"title"`
	CallNumber   sql.NullString `db:"call_number"`
	Barcode      sql.NullString `db:"barcode"`
	DateDLIngest sql.NullTime   `db:"date_dl_ingest"`
	Availability sql.NullString `db:"availability"`
	OCRLangHint  sql.NullString `db:"ocr_language_hint"`
	OCRHint      sql.NullString `db:"ocr_hint"`
	OCRCandidate sql.NullBool   `db:"ocr_candidate"`
}

type masterFileSummary struct {
	ID           int64          `db:"id"`
	Title        sql.NullString `db:"title"`
	Description  sql.NullString `db:"description"`
	Filename     sql.NullString `db:"filename"`
	TextSource   sql.NullInt64  `db:"text_source"`
	Text         sql.NullString `db:"transcription_text"`
	ParentPID    sql.NullString `db:"parent_pid"`
	OCRLangHint  sql.NullString `db:"ocr_language_hint"`
	OCRHint      sql.NullString `db:"ocr_hint"`
	OCRCandidate sql.NullBool   `db:"ocr_candidate"`
}

type componentSummary struct {
	ID           int64          `db:"id"`
	Title        sql.NullString `db:"title"`
	DateDLIngest sql.NullTime   `db:"date_dl_ingest"`
}

type pidSummary struct {
	ID           int64      `json:"id"`
	PID          string     `json:"pid"`
	Type         string     `json:"type"`
	Title        string     `json:"title,omitempty"`
	Filename     string     `json:"filename,omitempty"`
	Availability string     `json:"availability_policy,omitempty"`
	ParentPID    string     `json:"parent_metadata_pid,omitempty"`
	TextSource   string     `json:"text_source,omitempty"`
	ClonedFrom   *cloneData `json:"cloned_from,omitempty"`
	ocrSummary
}

func (svc *ServiceContext) getPIDSummary(c *gin.Context) {
	pid := c.Param("pid")
	log.Printf("INFO: get summary for %s", pid)

	// First try metadata...
	qSQL := `select m.id,type,title,a.name as availability,date_dl_ingest,
		ocr_language_hint,o.name as ocr_hint,ocr_candidate
		from metadata m left outer join ocr_hints o on o.id = m.ocr_hint_id
		left outer join availability_policies a on a.id = availability_policy_id
		where m.pid={:pid}`
	q := svc.DB.NewQuery(qSQL)
	q.Bind(dbx.Params{"pid": pid})
	var mdResp metadataSummary
	err := q.One(&mdResp)
	if err == nil {
		out := pidSummary{ID: mdResp.ID, PID: pid, Title: mdResp.Title, Availability: "private",
			Type: "sirsi_metadata"}
		if mdResp.Type == "XmlMetadata" {
			out.Type = "xml_metadata"
		} else if mdResp.Type == "ExternalMetadata" {
			out.Type = "external_metadata"
		}
		if mdResp.Availability.Valid {
			out.Availability = strings.ToLower(strings.Split(mdResp.Availability.String, " ")[0])
		}
		if mdResp.OCRLangHint.Valid {
			out.OCRLanguageHint = mdResp.OCRLangHint.String
		}
		if mdResp.OCRHint.Valid {
			out.OCRHint = mdResp.OCRHint.String
			out.OCRCandidate = mdResp.OCRCandidate.Bool
		}

		if mdResp.DateDLIngest.Valid {
			q = svc.DB.NewQuery("select id from units where include_in_dl=1 and metadata_id={:id}")
			q.Bind(dbx.Params{"id": mdResp.ID})
			var unitID int64
			err = q.Row(&unitID)
			if err == nil {
				txtInfo := svc.getTextInfo(unitID, "unit_id")
				out.HasOCR = txtInfo.HasOCR
				out.HasTranscription = txtInfo.HasTranscription
			}
		}

		c.JSON(http.StatusOK, out)
		return
	} else if err != sql.ErrNoRows {
		log.Printf("ERROR: unable to find PID (metadata) %s: %s", pid, err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}

	// try master file...
	qSQL = `select f.id,f.title,filename,text_source,transcription_text,m.pid as parent_pid,
		ocr_language_hint, o.name as ocr_hint,ocr_candidate
		from master_files f left outer join metadata m on m.id = f.metadata_id
		left outer join ocr_hints o on o.id = m.ocr_hint_id
		where f.pid={:pid}`
	q = svc.DB.NewQuery(qSQL)
	q.Bind(dbx.Params{"pid": pid})
	var mfResp masterFileSummary
	err = q.One(&mfResp)
	if err == nil {
		out := pidSummary{ID: mfResp.ID, PID: pid, Type: "master_file", Title: mfResp.Title.String,
			ParentPID: mfResp.ParentPID.String, Filename: mfResp.Filename.String}
		if mfResp.Text.Valid && mfResp.Text.String != "" {
			if mfResp.TextSource.Valid && mfResp.TextSource.Int64 == 2 {
				out.HasTranscription = true
			} else {
				out.HasOCR = true
			}
		}
		if mfResp.OCRLangHint.Valid {
			out.OCRLanguageHint = mfResp.OCRLangHint.String
		}
		if mfResp.OCRHint.Valid {
			out.OCRHint = mfResp.OCRHint.String
			out.OCRCandidate = mfResp.OCRCandidate.Bool
		}
		c.JSON(http.StatusOK, out)
		return
	} else if err != sql.ErrNoRows {
		log.Printf("ERROR: unable to find PID (master_file) %s: %s", pid, err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}

	// try component...
	q = svc.DB.NewQuery("select id,title,date_dl_ingest from components where pid={:pid}")
	q.Bind(dbx.Params{"pid": pid})
	var cResp componentSummary
	err = q.One(&cResp)
	if err == nil {
		out := pidSummary{ID: cResp.ID, PID: pid, Title: cResp.Title.String, Type: "component"}
		if cResp.DateDLIngest.Valid {
			txtInfo := svc.getTextInfo(cResp.ID, "component_id")
			out.HasOCR = txtInfo.HasOCR
			out.HasTranscription = txtInfo.HasTranscription
		}
		c.JSON(http.StatusOK, out)
		return
	} else if err != sql.ErrNoRows {
		log.Printf("ERROR: unable to find PID (component) %s: %s", pid, err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}

	log.Printf("WARNING: %s not found in database", pid)
	c.String(http.StatusNotFound, "not found")
}

func (svc *ServiceContext) getPIDType(c *gin.Context) {
	pid := c.Param("pid")
	log.Printf("INFO: get type for %s", pid)

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
		// No error; this is PID is metadata, find out the type
		if resp.Type == "SirsiMetadata" {
			log.Printf("%s is sirsi metadata", pid)
			c.String(http.StatusOK, "sirsi_metadata")
		} else if resp.Type == "XmlMetadata" {
			log.Printf("%s is xml metadata", pid)
			c.String(http.StatusOK, "xml_metadata")
		} else if resp.Type == "ExternalMetadata" && resp.System.String == "ArchivesSpace" {
			log.Printf("%s is archivesSpace metadata", pid)
			c.String(http.StatusOK, "archivesspace_metadata")
		} else if resp.Type == "ExternalMetadata" && resp.System.String == "Apollo" {
			log.Printf("%s is apollo metadata", pid)
			c.String(http.StatusOK, "apollo_metadata")
		} else if resp.Type == "ExternalMetadata" && resp.System.String == "JSTOR Forum" {
			log.Printf("%s is jstor metadata", pid)
			c.String(http.StatusOK, "jstor_metadata")
		} else {
			log.Printf("WARN: %s is an unsupported metadata type: %s", pid, resp.Type)
			c.String(http.StatusBadRequest, "unsupported metadata type")
		}
		return
	} else if err != sql.ErrNoRows {
		log.Printf("ERROR: unable to find PID (metadata) %s: %s", pid, err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}

	// see if it is a component...
	var ID uint64
	q = svc.DB.NewQuery(`select id from components where pid={:pid}`)
	q.Bind(dbx.Params{"pid": pid})
	err = q.Row(&ID)
	if err == nil {
		log.Printf("%s is a component", pid)
		c.String(http.StatusOK, "component")
		return
	} else if err != sql.ErrNoRows {
		log.Printf("ERROR: unable to find PID (component) %s: %s", pid, err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}

	// last chance... master file?
	q = svc.DB.NewQuery(`select id from master_files where pid={:pid}`)
	q.Bind(dbx.Params{"pid": pid})
	err = q.Row(&ID)
	if err == nil {
		log.Printf("%s is a master file", pid)
		c.String(http.StatusOK, "masterfile")
		return
	} else if err != sql.ErrNoRows {
		log.Printf("ERROR: unable to find PID (master_file) %s: %s", pid, err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}

	log.Printf("WARNING: PID %s not found in database", pid)
	c.String(http.StatusNotFound, "not found")
}

func (svc *ServiceContext) getPIDAccess(c *gin.Context) {
	pid := c.Param("pid")
	log.Printf("INFO: get rights for %s", pid)
	q := svc.DB.NewQuery(`select id,availability_policy_id from metadata where pid={:pid}`)
	q.Bind(dbx.Params{"pid": pid})
	var resp struct {
		ID      int64         `db:"id"`
		AvailID sql.NullInt64 `db:"availability_policy_id"`
	}
	err := q.One(&resp)
	if err != nil {
		if err != sql.ErrNoRows {
			log.Printf("ERROR: unable to find availability for %s: %s", pid, err.Error())
			c.String(http.StatusInternalServerError, err.Error())
			return
		}

		qSQL := `select f.id,availability_policy_id from master_files f
			inner join metadata m on m.id = f.metadata_id
			inner join availability_policies a on a.id = m.availability_policy_id
			where f.pid={:pid}`
		q = svc.DB.NewQuery(qSQL)
		q.Bind(dbx.Params{"pid": pid})
		err = q.One(&resp)
		if err != nil {
			if err != sql.ErrNoRows {
				log.Printf("ERROR: unable to find availability for %s: %s", pid, err.Error())
				c.String(http.StatusInternalServerError, err.Error())
			} else {
				log.Printf("WARNING: unable to find availability for %s", pid)
				c.String(http.StatusNotFound, "not found")
			}
			return
		}
	}

	if !resp.AvailID.Valid {
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
	} else if err != sql.ErrNoRows {
		log.Printf("ERROR: unable to find availability policy %d: %s", resp.AvailID.Int64, err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}

	log.Printf("WARNING: %s not found in database", pid)
	c.String(http.StatusNotFound, "not found")
}
