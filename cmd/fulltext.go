package main

import (
	"database/sql"
	"errors"
	"fmt"
	"log"
	"net/http"
	"regexp"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
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
	var mf masterFile
	whereClause := fmt.Sprintf("transcription_text is not null and transcription_text <> '' and %s=?", field)
	mfResp := svc.GDB.Select("transcription_text", "text_source").Where(whereClause, ID).First(&mf)
	if mfResp.Error != nil {
		if errors.Is(mfResp.Error, gorm.ErrRecordNotFound) == false {
			log.Printf("ERROR: searching master_file %d (%s)", ID, mfResp.Error.Error())
		} else {
			log.Printf("INFO: no text found for master_file %d", ID)
		}
		return textInfo{}
	}
	if !mf.TextSource.Valid {
		return textInfo{HasOCR: true}
	}
	if mf.TextSource.Int16 == 2 {
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

	var mfResp masterFile
	dbResp := svc.GDB.Where("pid=?", pid).Limit(1).Find(&mfResp)
	if dbResp.Error == nil {
		out := mfResp.TranscriptionText
		if txtType == "title" {
			out = mfResp.Title
		} else if txtType == "description" {
			out = mfResp.Description
		}
		log.Printf("%s text returned for master file %s", txtType, pid)
		c.String(http.StatusOK, spacesRegex.ReplaceAllString(out, " "))
		return
	} else if errors.Is(dbResp.Error, gorm.ErrRecordNotFound) == false {
		log.Printf("ERROR: unable to find PID (masterfile) for text request %s: %s", pid, dbResp.Error.Error())
		c.String(http.StatusInternalServerError, dbResp.Error.Error())
		return
	}

	// Try a metadata record...
	var mdResp metadata
	dbResp = svc.GDB.Where("pid=?", pid).First(&mdResp)
	if dbResp.Error == nil {
		unitID := c.Query("unit")
		if unitID == "" {
			var uID int64
			row := svc.GDB.Table("units").Select("id").Where("include_in_dl=1 and metadata_id=?", mdResp.ID).Limit(1).Row()
			err := row.Scan(&uID)
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
				out += fmt.Sprintf("[[ %s - %s ]]", mdResp.Title, mdResp.CallNumber)
			} else {
				out += fmt.Sprintf("[[ %s ]]\n", mdResp.Title)
			}
		}

		var mfResp []masterFile
		dbResp = svc.GDB.Where("unit_id=?", unitID).Find(&mfResp)
		if dbResp.Error != nil {
			if errors.Is(dbResp.Error, gorm.ErrRecordNotFound) == false {
				log.Printf("ERROR: unable to get masterfiles for unit %s: %s", unitID, dbResp.Error.Error())
				c.String(http.StatusInternalServerError, dbResp.Error.Error())
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
			out += spacesRegex.ReplaceAllString(mf.TranscriptionText, " ")
		}
		if pgBreak != "" {
			out += "\n\n[ END ]\n\n"
		}
		log.Printf("INFO: returning transcription for metadata %s", pid)
		c.String(http.StatusOK, out)
		return
	} else if errors.Is(dbResp.Error, gorm.ErrRecordNotFound) == false {
		log.Printf("ERROR: unable to find PID (metadata) for text request %s: %s", pid, dbResp.Error.Error())
		c.String(http.StatusInternalServerError, dbResp.Error.Error())
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
		log.Printf("INFO: ocr update request with invalid key [%s]", key)
		c.String(http.StatusUnauthorized, "unauthorized")
		return
	}

	if text == "" {
		log.Printf("INFO: text update called with no text")
		c.String(http.StatusBadRequest, "missing text payload")
		return
	}

	log.Printf("INFO: get current ocr info for %s", pid)
	var mf masterFile
	dbResp := svc.GDB.Where("pid=?", pid).First(&mf)
	if dbResp.Error != nil {
		if errors.Is(dbResp.Error, gorm.ErrRecordNotFound) == true {
			log.Printf("INFO: masterfile pid %s not found", pid)
			c.String(http.StatusNotFound, fmt.Sprintf("%s not found", pid))
			return
		}
		log.Printf("ERROR: unable to find master file pid %s: %s", pid, dbResp.Error.Error())
		c.String(http.StatusInternalServerError, dbResp.Error.Error())
		return
	}

	// from TrackSys: {ocr: 0, corrected_ocr: 1, transcription: 2}
	log.Printf("INFO: master file %s text_source is currently [%d]", pid, mf.TextSource.Int16)
	if mf.TextSource.Valid == false || mf.TextSource.Int16 == 0 {
		log.Printf("INFO: updating ocr text for masterfile %s", pid)
		mf.TranscriptionText = text
		mf.TextSource.Valid = true
		mf.TextSource.Int16 = 0
		dbResp = svc.GDB.Model(mf).Select("TranscriptionText", "TextSource").Updates(mf)
		if dbResp.Error != nil {
			log.Printf("ERROR: unable to update master file %s text: %s", pid, dbResp.Error.Error())
			c.String(http.StatusInternalServerError, dbResp.Error.Error())
			return
		}
		c.String(http.StatusOK, "Master File OCR text added")
		return
	}

	log.Printf("INFO: master file %s already has corrected or transcribed text; ocr update canceled", pid)
	c.String(http.StatusConflict, "Master File already has Corrected OCR or Transcription text")
}
