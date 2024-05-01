package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
	"net/url"
	"os"
	"path"
	"strings"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

// SAMPLE CURL:
// curl -X POST http://localhost:8180/api/transform -H "Content-Type: multipart/form-data" -F user=lf6f -F mode=test -F pid=uva-lib:729248 -F xsl=@/Users/lf6f/dev/test2.xsl -F "comment=just a test transform"

func (svc *ServiceContext) transformStatus(c *gin.Context) {
	uuid := c.Param("id")
	statusFileName := fmt.Sprintf("%s.log", uuid)
	statusPath := path.Join(svc.WorkDir, statusFileName)
	_, existErr := os.Stat(statusPath)
	if existErr != nil {
		log.Printf("INFO: %s not found", statusPath)
		c.String(http.StatusNotFound, fmt.Sprintf("%s not found", uuid))
		return
	}
	c.File(statusPath)
}

func (svc *ServiceContext) transformXMLMetadata(c *gin.Context) {
	computeID := c.PostForm("user")
	tgtPID := c.PostForm("pid")
	mode := c.PostForm("mode")
	key := c.PostForm("key")

	if key != svc.Key {
		c.String(http.StatusUnauthorized, "unauthorized")
		return
	}

	if mode != "global" && mode != "test" && mode != "single" {
		c.String(http.StatusBadRequest, "mode test, unit or global is required")
		return
	}
	if computeID == "" {
		c.String(http.StatusBadRequest, "user is required")
		return
	}
	if (mode == "single" || mode == "test") && tgtPID == "" {
		c.String(http.StatusBadRequest, "pid is required when mode is unit or test")
		return
	}

	userID, err := svc.verifyUser(computeID)
	if err != nil {
		log.Printf("ERROR: %s", err.Error())
		c.String(http.StatusUnauthorized, fmt.Sprintf("%s is not authorized", computeID))
		return
	}

	var xmlMD *metadata
	if tgtPID != "" {
		xmlMD, err = svc.getXMLMetadata(tgtPID)
		if err != nil {
			c.String(http.StatusBadRequest, fmt.Sprintf("pid %s is not valid", tgtPID))
			return
		}
	}

	if mode == "single" || mode == "test" {
		log.Printf("INFO: user %s:%d requests %s xml transform for %s", computeID, userID, mode, tgtPID)
	} else {
		log.Printf("INFO: user %s:%d requests %s xml transform", computeID, userID, mode)
	}

	// copy the uploaded XSL file to a working directory so it can be accessed with /api/stylesheet/xsl-filename
	uploadFile, header, err := c.Request.FormFile("xsl")
	defer uploadFile.Close()
	if err != nil {
		log.Printf("ERROR: unable to get xsl from post: %s", err.Error())
		c.String(http.StatusBadRequest, "xsl is required")
		return
	}

	tmpFileName := fmt.Sprintf("%s.xsl", uuid.New())
	xslFilePath := path.Join(svc.WorkDir, tmpFileName)
	xslFile, err := os.Create(xslFilePath)
	if err != nil {
		log.Printf("ERROR: couldn't create temp file for %s at %s: %s", header.Filename, xslFilePath, err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}
	defer xslFile.Close()
	_, copyErr := io.Copy(xslFile, uploadFile)
	if copyErr != nil {
		log.Printf("ERROR: unable to read xsl: %s", copyErr.Error())
		c.String(http.StatusBadRequest, "xsl is unreadable")
		return
	}

	// Test mode. Do the transform, but do not update the DB. Return the resulting XML
	if mode == "test" {
		out, err := svc.applyTransform(tgtPID, tmpFileName)
		if err != nil {
			log.Printf("ERROR: test transform failed %s", err.Error())
			c.String(http.StatusBadRequest, err.Error())
		} else {
			c.Header("Content-Type", "text/xml")
			c.String(http.StatusOK, string(out))
		}
		removeTempFile(xslFilePath)
		return

	}

	// Single mode. Do the transform, update the DB and return the resulting XML
	if mode == "single" {
		out, err := svc.applyTransform(tgtPID, tmpFileName)
		if err != nil {
			log.Printf("ERROR: test transform failed %s", err.Error())
			c.String(http.StatusBadRequest, err.Error())
			removeTempFile(xslFilePath)
			return
		}

		err = svc.updateXMLMetadataRecord(out, xmlMD)
		if err != nil {
			log.Printf("ERROR: unable to update metadata %s: %s", tgtPID, err.Error())
			c.String(http.StatusInternalServerError, err.Error())
			removeTempFile(xslFilePath)
			return
		}
		removeTempFile(xslFilePath)
		c.Header("Content-Type", "text/xml")
		c.String(http.StatusOK, string(out))
		return
	}

	// Global transform is done in a goroutine with the root filename as the key
	statusKey, err := svc.globalTransform(tmpFileName)
	log.Printf("INFO: global transform started; status key %s", statusKey)
	c.String(http.StatusOK, statusKey)
}

func removeTempFile(tmpFilePath string) {
	log.Printf("INFO: cleanup temporary file %s", tmpFilePath)
	err := os.Remove(tmpFilePath)
	if err != nil {
		log.Printf("ERROR: unable to remove %s", tmpFilePath)
	}
}

func (svc *ServiceContext) getXMLMetadata(pid string) (*metadata, error) {
	var md metadata
	dbResp := svc.GDB.Where("pid=? and type=?", pid, "XmlMetadata").First(&md)
	if dbResp.Error != nil {
		log.Printf("ERROR: query for %s failed: %s", pid, dbResp.Error.Error())
		return nil, dbResp.Error
	}
	return &md, nil
}

func (svc *ServiceContext) verifyUser(computeID string) (int64, error) {
	var userID int64
	row := svc.GDB.Table("staff_members").Select("id").Where("computing_id=?", computeID).Limit(1).Row()
	err := row.Scan(&userID)
	if err != nil {
		return 0, err
	}
	return userID, nil
}

func (svc *ServiceContext) applyTransform(mdPID string, xslName string) ([]byte, error) {
	payload := url.Values{}
	log.Printf("INFO: apply transform %s to metadata %s", xslName, mdPID)
	payload.Set("source", fmt.Sprintf("%s/metadata/%s?type=mods", svc.APIURL, mdPID))
	payload.Set("style", fmt.Sprintf("%s/stylesheet/%s", svc.APIURL, xslName))
	payload.Set("clear-stylesheet-cache", "yes")
	xformBytes, err := svc.saxonTransform(&payload)
	if err != nil {
		return nil, err
	}
	return xformBytes, nil
}

func (svc *ServiceContext) updateXMLMetadataRecord(newMD []byte, xmlMD *metadata) error {
	if string(newMD) == xmlMD.DescMetadata {
		log.Printf("INFO: no changes detected in %s after transform", xmlMD.PID)
		return nil
	}
	log.Printf("INFO: updating xml metadata for %s", xmlMD.PID)
	xmlMD.UpdatedAt.Time = time.Now()
	xmlMD.UpdatedAt.Valid = true
	xmlMD.DescMetadata = string(newMD)
	err := svc.GDB.Model(xmlMD).Select("UpdatedAt", "DescMetadata").Updates(xmlMD).Error
	if err != nil {
		return err
	}
	return nil
}

func (svc *ServiceContext) globalTransform(xslName string) (string, error) {
	xformUUID := strings.Split(xslName, ".xsl")[0]
	statusFileName := fmt.Sprintf("%s.log", xformUUID)
	statusFilePath := path.Join(svc.WorkDir, statusFileName)
	logFile, err := os.Create(statusFilePath)
	if err != nil {
		return "", err
	}
	log.Printf("INFO: kicking off global transform in goroutine")
	go svc.globalWorker(xslName, logFile)
	return xformUUID, nil
}

func (svc *ServiceContext) globalWorker(xslName string, logFile *os.File) {
	defer logFile.Close()
	pageSize := 1000
	startOffset := 0
	xslFilePath := path.Join(svc.WorkDir, xslName)
	done := false

	for !done {
		var mdRecs []metadata
		dbResp := svc.GDB.Where("type=?", "XmlMetadata").Offset(startOffset).Limit(pageSize).Find(&mdRecs)
		if dbResp.Error != nil {
			log.Printf("ERROR: unable to get XmlMetadata records: %s", dbResp.Error.Error())
		}

		logFile.WriteString(fmt.Sprintf("\nProcessing batch of metadata records %d - %d\n", startOffset, startOffset+pageSize))
		if len(mdRecs) < pageSize {
			done = true
		}

		for _, md := range mdRecs {
			newXML, err := svc.applyTransform(md.PID, xslName)
			if err != nil {
				log.Printf("ERROR: transform %s with %s failed: %s", md.PID, xslName, err.Error())
				logFile.WriteString(fmt.Sprintf("\nERROR: %s: %s\n", md.PID, err.Error()))
				logFile.WriteString("Transform FAILED\n")
				removeTempFile(xslFilePath)
				return
			}

			err = svc.updateXMLMetadataRecord(newXML, &md)
			if err != nil {
				log.Printf("ERROR: unable to save metadata %s: %s", md.PID, err.Error())
				logFile.WriteString(fmt.Sprintf("\nERROR: unable to save metadata %s version: %s\n", md.PID, err.Error()))
				logFile.WriteString("Transform FAILED\n")
				removeTempFile(xslFilePath)
				return
			}
			logFile.WriteString(".")
		}

		startOffset += pageSize
	}

	removeTempFile(xslFilePath)
	logFile.WriteString("\nDONE\n")
	log.Printf("INFO: global transform with %s is done", xslName)
}
