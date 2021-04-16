package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"regexp"
	"strings"

	"github.com/gin-gonic/gin"
	dbx "github.com/go-ozzo/ozzo-dbx"
)

type metadataSummary struct {
	ID           int64          `db:"id"`
	Type         string         `db:"type"`
	Title        string         `db:"title"`
	CallNumber   sql.NullString `db:"call_number"`
	DateDLIngest sql.NullTime   `db:"date_dl_ingest"`
	Availability sql.NullString `db:"availability"`
	OCRLangHint  sql.NullString `db:"ocr_language_hint"`
	OCRHint      sql.NullString `db:"ocr_hint"`
	OCRCandidate sql.NullBool   `db:"ocr_candidate"`
}

type masterFileSummary struct {
	ID          int64          `db:"id"`
	Title       sql.NullString `db:"title"`
	Description sql.NullString `db:"description"`
	Filename    sql.NullString `db:"filename"`
	TextSource  sql.NullInt64  `db:"text_source"`
	Text        sql.NullString `db:"transcription_text"`
	ParentPID   sql.NullString `db:"parent_pid"`
}

type componentSummary struct {
	ID           int64          `db:"id"`
	Title        sql.NullString `db:"title"`
	DateDLIngest sql.NullTime   `db:"date_dl_ingest"`
}

type textInfo struct {
	HasOCR           bool `json:"has_ocr"`
	HasTranscription bool `json:"has_transcription"`
}

type ocrSummary struct {
	OCRHint         string `json:"ocr_hint,omitempty"`
	OCRLanguageHint string `json:"ocr_language_hint,omitempty"`
	OCRCandidate    bool   `json:"ocr_candidate"`
	textInfo
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
	log.Printf("Get summary for %s", pid)

	// First try metadata...
	sql := `select m.id,type,title,a.name as availability,date_dl_ingest,
		ocr_language_hint,o.name as ocr_hint,ocr_candidate
		from metadata m left outer join ocr_hints o on o.id = m.ocr_hint_id
		left outer join availability_policies a on a.id = availability_policy_id
		where m.pid={:pid}`
	q := svc.DB.NewQuery(sql)
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
	}

	// try master file...
	sql = `select f.id,f.title,filename,text_source,transcription_text,m.pid as parent_pid
		from master_files f left outer join metadata m on m.id = f.metadata_id where f.pid={:pid}`
	q = svc.DB.NewQuery(sql)
	q.Bind(dbx.Params{"pid": pid})
	var mfResp masterFileSummary
	err = q.One(&mfResp)
	if err == nil {
		out := pidSummary{ID: mfResp.ID, PID: pid, Type: "master_file", Title: mfResp.Title.String, Filename: mfResp.Filename.String}
		if mfResp.Text.Valid && mfResp.Text.String != "" {
			if mfResp.TextSource.Valid && mfResp.TextSource.Int64 == 2 {
				out.HasTranscription = true
			} else {
				out.HasOCR = true
			}
		}
		c.JSON(http.StatusOK, out)
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
	}

	c.String(http.StatusNotFound, "not found")
}

func (svc *ServiceContext) getTextInfo(ID int64, field string) textInfo {
	sqlQ := fmt.Sprintf(`select transcription_text, text_source from master_files where
	transcription_text is not null and transcription_text <> '' and %s={:id}
	limit 1`, field)
	q := svc.DB.NewQuery(sqlQ)
	q.Bind(dbx.Params{"id": ID})
	var resp struct {
		Text   sql.NullString `db:"transcription_text"`
		Source sql.NullInt64  `db:"text_source"`
	}
	err := q.One(&resp)
	if err != nil {
		return textInfo{}
	}
	if !resp.Source.Valid {
		return textInfo{HasOCR: true}
	}
	if resp.Source.Int64 == 2 {
		return textInfo{HasTranscription: true}
	}
	return textInfo{HasOCR: true}
}

func (svc *ServiceContext) getPIDText(c *gin.Context) {
	pid := c.Param("pid")
	txtType := c.Query("type")
	if txtType == "" {
		txtType = "transcription"
	}
	if !(txtType == "transcription" || txtType == "title" || txtType == "description") {
		c.String(http.StatusBadRequest, "invalid text type")
		return
	}
	log.Printf("Get full text for %s", pid)
	spacesRegex := regexp.MustCompile(`\s+`)

	sql := `select id,title,description,transcription_text from master_files where pid={:pid}`
	q := svc.DB.NewQuery(sql)
	q.Bind(dbx.Params{"pid": pid})
	var mfResp masterFileSummary
	err := q.One(&mfResp)
	if err == nil {
		out := mfResp.Text.String
		if txtType == "title" {
			out = mfResp.Title.String
		} else if txtType == "description" {
			out = mfResp.Description.String
		}
		c.String(http.StatusOK, spacesRegex.ReplaceAllString(out, " "))
		return
	}

	// Try a metadata record...
	sql = `select id,type,title,call_number from metadata where pid={:pid}`
	q = svc.DB.NewQuery(sql)
	q.Bind(dbx.Params{"pid": pid})
	var mdResp metadataSummary
	err = q.One(&mdResp)
	if err == nil {
		unitID := c.Query("unit")
		if unitID == "" {
			sql := `select id from units where include_in_dl =1 and metadata_id={:id} limit 1`
			q := svc.DB.NewQuery(sql)
			q.Bind(dbx.Params{"id": mdResp.ID})
			var uID int64
			err := q.Row(&uID)
			if err != nil {
				log.Printf("Unable to find unit for text api call: %s", err.Error())
				c.String(http.StatusNotFound, "not found")
				return
			}
			unitID = fmt.Sprintf("%d", uID)
		}
		pgBreak := c.Query("pagebreak")
		out := ""
		if pgBreak != "" {
			if mdResp.Type == "SirsiMetadata" {
				out += fmt.Sprintf("[[ %s - %s ]]", mdResp.Title, mdResp.CallNumber.String)
			} else {
				out += fmt.Sprintf("[[ %s ]]\n", mdResp.Title)
			}
		}

		sql := `select id,title,description,transcription_text from master_files where unit_id={:uid}`
		q := svc.DB.NewQuery(sql)
		q.Bind(dbx.Params{"uid": unitID})
		var mfResp []masterFileSummary
		err := q.All(&mfResp)
		if err != nil {
			log.Printf("Unable to find master files for text api call: %s", err.Error())
			c.String(http.StatusNotFound, "not found")
			return
		}
		for pg, mf := range mfResp {
			if pgBreak != "" {
				out += fmt.Sprintf("\n\n[ PAGE %d ]\n\n", (pg + 1))
			} else {
				out += "\n"
			}
			out += spacesRegex.ReplaceAllString(mf.Text.String, " ")
		}
		if pgBreak != "" {
			out += "\n\n[ END ]\n\n"
		}
		c.String(http.StatusOK, out)
		return
	}

	c.String(http.StatusNotFound, "not found")
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

func (svc *ServiceContext) getPIDAccess(c *gin.Context) {
	pid := c.Param("pid")
	log.Printf("Get rights for %s", pid)
	q := svc.DB.NewQuery(`select id,availability_policy_id from metadata where pid={:pid}`)
	q.Bind(dbx.Params{"pid": pid})
	var resp struct {
		ID      int64         `db:"id"`
		AvailID sql.NullInt64 `db:"availability_policy_id"`
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
	}

	c.String(http.StatusNotFound, "not found")
}
