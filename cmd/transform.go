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
	dbx "github.com/go-ozzo/ozzo-dbx"
	"github.com/google/uuid"
)

// SAMPLE CURL:
// curl -X POST http://localhost:8180/api/transform -H "Content-Type: multipart/form-data" -F user=lf6f -F mode=test -F pid=uva-lib:729248 -F xsl=@/Users/lf6f/dev/test2.xsl -F "comment=just a test transform"

type xmlMetadata struct {
	ID       int64  `db:"id"`
	PID      string `db:"pid"`
	Metadata string `db:"desc_metadata"`
}

type metadataVersion struct {
	MetadataID int64  `db:"metadata_id"`
	UserID     int64  `db:"staff_member_id"`
	Metadata   string `db:"desc_metadata"`
	Tag        string `db:"version_tag"`
	Comment    string `db:"comment"`
}

// TableName sets the name of the table in the DB that this struct binds to
func (u metadataVersion) TableName() string {
	return "metadata_versions"
}

func (svc *ServiceContext) transformXMLMetadata(c *gin.Context) {
	computeID := c.PostForm("user")
	tgtPID := c.PostForm("pid")
	mode := c.PostForm("mode")
	comment := c.PostForm("comment")

	if mode != "global" && mode != "test" && mode != "single" {
		c.String(http.StatusBadRequest, "mode test, unit or global is required")
		return
	}
	if computeID == "" {
		c.String(http.StatusBadRequest, "user is required")
		return
	}
	if comment == "" && mode != "test" {
		c.String(http.StatusBadRequest, "comment is required")
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

	var xmlMD *xmlMetadata
	if tgtPID != "" {
		xmlMD, err = svc.getMetadataPID(tgtPID)
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
		log.Printf("ERROR: unable to read xsl: %s", err.Error())
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

		err = svc.createMetadataVersion(out, xmlMD, tmpFileName, userID, comment)
		if err != nil {
			log.Printf("ERROR: unable to save metadata %s version: %s", tgtPID, err.Error())
			c.String(http.StatusInternalServerError, err.Error())
			removeTempFile(xslFilePath)
			return
		}
		removeTempFile(xslFilePath)
		c.Header("Content-Type", "text/xml")
		c.String(http.StatusOK, string(out))
		return
	}

	// Global transform
	// TODO

	c.String(http.StatusNotImplemented, "global transform not implemented")
}

func removeTempFile(tmpFilePath string) {
	log.Printf("INFO: cleanup temporary file %s", tmpFilePath)
	err := os.Remove(tmpFilePath)
	if err != nil {
		log.Printf("ERROR: unable to remove %s", tmpFilePath)
	}
}

func (svc *ServiceContext) getMetadataPID(pid string) (*xmlMetadata, error) {
	q := svc.DB.NewQuery("select id,pid,desc_metadata from metadata where pid={:pid} and type={:t}")
	q.Bind(dbx.Params{"pid": pid})
	q.Bind(dbx.Params{"t": "XmlMetadata"})
	var md xmlMetadata
	err := q.One(&md)
	if err != nil {
		log.Printf("ERROR: query for %s failed: %s", pid, err.Error())
		return nil, err
	}
	return &md, nil
}

func (svc *ServiceContext) verifyUser(computeID string) (int64, error) {
	q := svc.DB.NewQuery("select id from staff_members where computing_id={:cid}")
	q.Bind(dbx.Params{"cid": computeID})
	var userID int64
	err := q.Row(&userID)
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

func (svc *ServiceContext) createMetadataVersion(newMD []byte, xmlMD *xmlMetadata, xslFileName string, userID int64, comment string) error {
	if string(newMD) == xmlMD.Metadata {
		log.Printf("INFO: no changes detected in %s after transform", xmlMD.PID)
		return nil
	}
	log.Printf("INFO: creating new metadata version for %s", xmlMD.PID)

	tag := strings.Split(xslFileName, ".")[0]
	version := metadataVersion{MetadataID: xmlMD.ID, UserID: userID, Tag: tag, Metadata: xmlMD.Metadata, Comment: comment}
	err := svc.DB.Model(&version).Insert()
	if err != nil {
		return err
	}

	q := svc.DB.NewQuery("update metadata set updated_at={:t}, desc_metadata={:m} where id={:id}")
	q.Bind(dbx.Params{"t": time.Now()})
	q.Bind(dbx.Params{"m": string(newMD)})
	q.Bind(dbx.Params{"id": xmlMD.ID})
	_, err = q.Execute()
	if err != nil {
		return err
	}

	return nil
}

func (svc *ServiceContext) globalTransform(userID int64, unitPID string, xslName string) {
}
