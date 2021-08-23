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
		if err != sql.ErrNoRows {
			log.Printf("ERROR: searching master_file %d (%s)", ID, err.Error())
		} else {
			log.Printf("INFO: no text found for master_file %d", ID)
		}
		// we should propagate the error correctly!!!
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
	log.Printf("INFO: get full text for %s", pid)
	spacesRegex := regexp.MustCompile(`\s+`)

	qSQL := `select id,title,description,transcription_text from master_files where pid={:pid}`
	q := svc.DB.NewQuery(qSQL)
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
		log.Printf("%s text returned for master file %s", txtType, pid)
		c.String(http.StatusOK, spacesRegex.ReplaceAllString(out, " "))
		return
	} else if err != sql.ErrNoRows {
		log.Printf("ERROR: unable to find PID (masterfile) for text request %s: %s", pid, err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}

	// Try a metadata record...
	qSQL = `select id,type,title,call_number from metadata where pid={:pid}`
	q = svc.DB.NewQuery(qSQL)
	q.Bind(dbx.Params{"pid": pid})
	var mdResp metadataSummary
	err = q.One(&mdResp)
	if err == nil {
		unitID := c.Query("unit")
		if unitID == "" {
			q := svc.DB.NewQuery(`select id from units where include_in_dl=1 and metadata_id={:id} limit 1`)
			q.Bind(dbx.Params{"id": mdResp.ID})
			var uID int64
			err := q.Row(&uID)
			if err != nil {
				if err != sql.ErrNoRows {
					log.Printf("ERROR: find unit for metadata %s failed for text api call: %s", pid, err.Error())
					c.String(http.StatusInternalServerError, err.Error())
				} else {
					log.Printf("WARNING: unable to find unit for text api call")
					c.String(http.StatusNotFound, "not found")
				}
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

		qSQL := `select id,title,description,transcription_text from master_files where unit_id={:uid}`
		q := svc.DB.NewQuery(qSQL)
		q.Bind(dbx.Params{"uid": unitID})
		var mfResp []masterFileSummary
		err := q.All(&mfResp)
		if err != nil {
			if err != sql.ErrNoRows {
				log.Printf("ERROR: unable to get masterfiles for unit %s: %s", unitID, err.Error())
				c.String(http.StatusInternalServerError, err.Error())
			} else {
				log.Printf("WARNING: no masterfiles found for unit %s", unitID)
				c.String(http.StatusNotFound, "not found")
			}
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
		log.Printf("INFO: returning transcription for metadata %s", pid)
		c.String(http.StatusOK, out)
		return
	} else if err != sql.ErrNoRows {
		log.Printf("ERROR: unable to find PID (metadata) for text request %s: %s", pid, err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}

	log.Printf("WARNING: text requested for PID %s, which is not a master file nor metadata record", pid)
	c.String(http.StatusNotFound, "not found")
}

func (svc *ServiceContext) updatePIDText(c *gin.Context) {
	pid := c.Param("pid")
	text := c.PostForm("text")
	key := c.PostForm("key")
	log.Printf("INFO: received request to update masterfile %s with OCR data", pid)

	if key == "" {
		log.Printf("INFO: ocr update request is missing key")
		c.String(http.StatusUnauthorized, "unauthorized")
		return
	}
	if key != svc.Key {
		log.Printf("INFO: ocr update request has mismatched key")
		c.String(http.StatusUnauthorized, "unauthorized")
		return
	}

	if text == "" {
		log.Printf("INFO: text update called with no text")
		c.String(http.StatusBadRequest, "missing text payload")
		return
	}

	log.Printf("INFO: get current ocr info for %s", pid)
	q := svc.DB.NewQuery("select id,text_source from master_files where pid={:pid}")
	q.Bind(dbx.Params{"pid": pid})
	var dbResp struct {
		ID         int64         `db:"id"`
		TextSource sql.NullInt64 `db:"text_source"`
	}
	err := q.One(&dbResp)
	if err != nil {
		if err == sql.ErrNoRows {
			log.Printf("INFO: masterfile pid %s not found", pid)
			c.String(http.StatusNotFound, fmt.Sprintf("%s not found", pid))
			return
		}
		log.Printf("ERROR: unable to find master file pid %s: %s", pid, err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}

	// from TrackSys: {ocr: 0, corrected_ocr: 1, transcription: 2}
	log.Printf("INFO: master file %s text_source is currently [%d]", pid, dbResp.TextSource.Int64)
	if dbResp.TextSource.Valid == false || dbResp.TextSource.Int64 == 0 {
		log.Printf("INFO: updating ocr text for masterfile %s", pid)
		q := svc.DB.NewQuery("update master_files set transcription_text={:txt}, text_source={:s} where id={:id}")
		q.Bind(dbx.Params{"txt": text})
		q.Bind(dbx.Params{"s": 0})
		q.Bind(dbx.Params{"id": dbResp.ID})
		_, err := q.Execute()
		if err != nil {
			log.Printf("ERROR: unable to update master file %s text: %s", pid, err.Error())
			c.String(http.StatusInternalServerError, err.Error())
			return
		}
		c.String(http.StatusOK, "Master File OCR text added")
		return
	}

	log.Printf("INFO: master file %s already has corrected or transcribed text; ocr update canceled", pid)
	c.String(http.StatusConflict, "Master File already has Corrected OCR or Transcription text")
}
