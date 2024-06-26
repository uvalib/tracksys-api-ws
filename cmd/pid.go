package main

import (
	"errors"
	"fmt"
	"log"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type pidSummary struct {
	ID              int64      `json:"id"`
	PID             string     `json:"pid"`
	Type            string     `json:"type"`
	Title           string     `json:"title,omitempty"`
	Filename        string     `json:"filename,omitempty"`
	Availability    string     `json:"availability_policy,omitempty"`
	ParentPID       string     `json:"parent_metadata_pid,omitempty"`
	TextSource      string     `json:"text_source,omitempty"`
	ClonedFrom      *cloneData `json:"cloned_from,omitempty"`
	Barcode         string     `json:"barcode,omitempty"`
	CallNumber      string     `json:"call_number,omitempty"`
	CatalogKey      string     `json:"catalog_key,omitempty"`
	ContentAdvisory string     `json:"advisory,omitempty"`
	ocrSummary
}

func (svc *ServiceContext) getCatKeySummary(c *gin.Context) {
	catKey := c.Param("key")
	log.Printf("INFO: get summary for %s", catKey)
	var md metadata
	err := svc.GDB.Preload("AvailabilityPolicy").Preload("OCRHint").Where("catalog_key=?", catKey).First(&md).Error
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) == false {
			log.Printf("INFO: key %s not found", catKey)
			c.String(http.StatusNotFound, fmt.Sprintf("catalog key %s not found", catKey))
		} else {
			log.Printf("ERROR: unable to get details for %s: %s", catKey, err.Error())
			c.String(http.StatusInternalServerError, err.Error())
		}
		return
	}
	out := pidSummary{ID: md.ID,
		PID:          md.PID,
		Title:        md.Title,
		Availability: "private",
		Type:         "sirsi_metadata",
		CatalogKey:   md.CatalogKey,
		Barcode:      md.Barcode,
		CallNumber:   md.CallNumber,
	}
	if md.AvailabilityPolicyID > 0 {
		out.Availability = strings.ToLower(strings.Split(md.AvailabilityPolicy.Name, " ")[0])
	}

	if md.OCRHintID > 0 {
		out.OCRHint = md.OCRHint.Name
		out.OCRCandidate = md.OCRHint.OCRCandidate
		out.OCRLanguageHint = md.OCRLanguageHint
	}

	if md.DateDLIngest.Valid {
		var unitID int64
		row := svc.GDB.Table("units").Select("id").Where("include_in_dl=1 and metadata_id=?", md.ID).Limit(1).Row()
		err := row.Scan(&unitID)
		if err == nil {
			log.Printf("INFO: lookup text info for metadata %s, unit %d", md.PID, unitID)
			txtInfo := svc.getTextInfo(unitID, "unit_id")
			out.HasOCR = txtInfo.HasOCR
			out.HasTranscription = txtInfo.HasTranscription
		}
	}
	c.JSON(http.StatusOK, out)
}

func (svc *ServiceContext) getPIDSummary(c *gin.Context) {
	pid := c.Param("pid")
	log.Printf("INFO: get summary for %s", pid)

	// First try metadata...
	var md metadata
	mdResp := svc.GDB.Preload("AvailabilityPolicy").Preload("OCRHint").Where("pid=?", pid).First(&md)
	if mdResp.Error == nil {
		out := pidSummary{ID: md.ID, PID: pid, Title: md.Title, Availability: "private", Type: "sirsi_metadata"}
		if md.Type == "XmlMetadata" {
			out.Type = "xml_metadata"

			// advisory example: <abstract type="Content advice">This item may include language or imagery that is offensive, oppressive, harmful, or inappropriate for some contexts.</abstract>
			advIdx := strings.Index(md.DescMetadata, "Content advice")
			if advIdx > -1 {
				clipped := md.DescMetadata[advIdx:]
				txtIdx := strings.Index(clipped, ">")
				msg := clipped[txtIdx+1:]
				endIdx := strings.Index(msg, "<")
				out.ContentAdvisory = msg[:endIdx]
			}
		} else if md.Type == "ExternalMetadata" {
			out.Type = "external_metadata"
		}
		if md.AvailabilityPolicyID > 0 {
			out.Availability = strings.ToLower(strings.Split(md.AvailabilityPolicy.Name, " ")[0])
		}

		if md.OCRHintID > 0 {
			out.OCRHint = md.OCRHint.Name
			out.OCRCandidate = md.OCRHint.OCRCandidate
			out.OCRLanguageHint = md.OCRLanguageHint
		}

		if md.DateDLIngest.Valid {
			var unitID int64
			row := svc.GDB.Table("units").Select("id").Where("include_in_dl=1 and metadata_id=?", md.ID).Limit(1).Row()
			err := row.Scan(&unitID)
			if err == nil {
				log.Printf("INFO: lookup text info for metadata %s, unit %d", md.PID, unitID)
				txtInfo := svc.getTextInfo(unitID, "unit_id")
				out.HasOCR = txtInfo.HasOCR
				out.HasTranscription = txtInfo.HasTranscription
			}
		}

		if md.Type == "SirsiMetadata" {
			out.CatalogKey = md.CatalogKey
			out.Barcode = md.Barcode
			out.CallNumber = md.CallNumber
		}

		c.JSON(http.StatusOK, out)
		return
	} else if errors.Is(mdResp.Error, gorm.ErrRecordNotFound) == false {
		log.Printf("ERROR: unable to find PID (metadata) %s: %s", pid, mdResp.Error.Error())
		c.String(http.StatusInternalServerError, mdResp.Error.Error())
		return
	}

	// try master file...
	var mf masterFile
	mfResp := svc.GDB.Preload("Metadata").Preload("Metadata.OCRHint").Preload("Metadata.AvailabilityPolicy").Where("pid=?", pid).First(&mf)
	if mfResp.Error == nil {
		out := pidSummary{ID: mf.ID, PID: pid, Type: "master_file", Title: mf.Title,
			ParentPID: mf.Metadata.PID, Filename: mf.Filename}
		if mf.TranscriptionText != "" {
			if mf.TextSource.Valid && mf.TextSource.Int64 == 2 {
				out.HasTranscription = true
			} else {
				out.HasOCR = true
			}
		}

		if mf.Metadata.AvailabilityPolicyID > 0 {
			out.Availability = strings.ToLower(strings.Split(mf.Metadata.AvailabilityPolicy.Name, " ")[0])
		}
		if mf.Metadata.OCRLanguageHint != "" {
			out.OCRLanguageHint = mf.Metadata.OCRLanguageHint
		}
		if mf.Metadata.OCRHintID > 0 {
			out.OCRHint = mf.Metadata.OCRHint.Name
			out.OCRCandidate = mf.Metadata.OCRHint.OCRCandidate
		}
		if mf.Metadata.Type == "SirsiMetadata" {
			out.CatalogKey = mf.Metadata.CatalogKey
			out.Barcode = mf.Metadata.Barcode
			out.CallNumber = mf.Metadata.CallNumber
		}
		c.JSON(http.StatusOK, out)
		return
	} else if errors.Is(mfResp.Error, gorm.ErrRecordNotFound) == false {
		log.Printf("ERROR: unable to find PID (master_file) %s: %s", pid, mfResp.Error.Error())
		c.String(http.StatusInternalServerError, mfResp.Error.Error())
		return
	}

	// try component...
	var cmp component
	cErr := svc.GDB.Where("pid=?", pid).First(&cmp)
	if cErr.Error == nil {
		out := pidSummary{ID: cmp.ID, PID: pid, Title: cmp.Title, Type: "component"}
		if cmp.DateDLIngest.Valid {
			txtInfo := svc.getTextInfo(cmp.ID, "component_id")
			out.HasOCR = txtInfo.HasOCR
			out.HasTranscription = txtInfo.HasTranscription
		}
		c.JSON(http.StatusOK, out)
		return
	} else if errors.Is(cErr.Error, gorm.ErrRecordNotFound) == false {
		log.Printf("ERROR: unable to find PID (component) %s: %s", pid, cErr.Error.Error())
		c.String(http.StatusInternalServerError, cErr.Error.Error())
		return
	}

	log.Printf("WARNING: %s not found in database", pid)
	c.String(http.StatusNotFound, "not found")
}

func (svc *ServiceContext) getPIDType(c *gin.Context) {
	pid := c.Param("pid")
	log.Printf("INFO: get type for %s", pid)

	// First try metadata
	var md metadata
	dbResp := svc.GDB.Preload("ExternalSystem").Where("pid=?", pid).First(&md)
	if dbResp.Error == nil {
		log.Printf("%+v", md.ExternalSystem)
		if md.Type == "SirsiMetadata" {
			log.Printf("INFO: %s is sirsi metadata", pid)
			c.String(http.StatusOK, "sirsi_metadata")
		} else if md.Type == "XmlMetadata" {
			log.Printf("INFO: %s is xml metadata", pid)
			c.String(http.StatusOK, "xml_metadata")
		} else if md.Type == "ExternalMetadata" && md.ExternalSystem.Name == "ArchivesSpace" {
			log.Printf("INFO: %s is archivesSpace metadata", pid)
			c.String(http.StatusOK, "archivesspace_metadata")
		} else if md.Type == "ExternalMetadata" && md.ExternalSystem.Name == "Apollo" {
			log.Printf("INFO: %s is apollo metadata", pid)
			c.String(http.StatusOK, "apollo_metadata")
		} else if md.Type == "ExternalMetadata" && md.ExternalSystem.Name == "JSTOR Forum" {
			log.Printf("INFO: %s is jstor metadata", pid)
			c.String(http.StatusOK, "jstor_metadata")
		} else {
			log.Printf("WARN: %s is an unsupported metadata type: %s", pid, md.Type)
			c.String(http.StatusBadRequest, "unsupported metadata type")
		}
		return
	} else if errors.Is(dbResp.Error, gorm.ErrRecordNotFound) == false {
		log.Printf("ERROR: unable to find PID (metadata) %s: %s", pid, dbResp.Error.Error())
		c.String(http.StatusInternalServerError, dbResp.Error.Error())
		return
	}

	// see if it is a component...
	var cnt int64
	dbResp = svc.GDB.Table("components").Where("pid=?", pid).Count(&cnt)
	if dbResp.Error == nil {
		if cnt == 1 {
			log.Printf("%s is a component", pid)
			c.String(http.StatusOK, "component")
			return
		}
	} else if errors.Is(dbResp.Error, gorm.ErrRecordNotFound) == false {
		log.Printf("ERROR: unable to find PID (component) %s: %s", pid, dbResp.Error.Error())
		c.String(http.StatusInternalServerError, dbResp.Error.Error())
		return
	}

	// last chance... master file?
	dbResp = svc.GDB.Table("master_files").Where("pid=?", pid).Count(&cnt)
	if dbResp.Error == nil {
		if cnt == 1 {
			log.Printf("%s is a master file", pid)
			c.String(http.StatusOK, "masterfile")
			return
		}
	} else if errors.Is(dbResp.Error, gorm.ErrRecordNotFound) == false {
		log.Printf("ERROR: unable to find PID (master_file) %s: %s", pid, dbResp.Error.Error())
		c.String(http.StatusInternalServerError, dbResp.Error.Error())
		return
	}

	log.Printf("WARNING: PID %s not found in database", pid)
	c.String(http.StatusNotFound, "not found")
}
