package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"path/filepath"
	"strings"

	"github.com/gin-gonic/gin"
	dbx "github.com/go-ozzo/ozzo-dbx"
	_ "github.com/go-sql-driver/mysql"
)

// ServiceContext contains common data used by all handlers
type ServiceContext struct {
	Version       string
	SaxonURL      string
	PDFServiceURL string
	IIIFManURL    string
	IIIFURL       string
	DB            *dbx.DB
}

// InitializeService sets up the service context for all API handlers
func InitializeService(version string, cfg *ServiceConfig) *ServiceContext {
	ctx := ServiceContext{Version: version,
		SaxonURL:      cfg.SaxonURL,
		PDFServiceURL: cfg.PDFServiceURL,
		IIIFManURL:    cfg.IIIFManURL,
		IIIFURL:       cfg.IIIFURL,
	}

	log.Printf("Connecting to DB...")
	connectStr := fmt.Sprintf("%s:%s@tcp(%s)/%s?parseTime=true",
		cfg.DB.User, cfg.DB.Pass, cfg.DB.Host, cfg.DB.Name)
	db, err := dbx.Open("mysql", connectStr)
	if err != nil {
		log.Fatal(err)
	}
	ctx.DB = db
	db.LogFunc = log.Printf
	log.Printf("DB Connection established")

	return &ctx
}

// IgnoreFavicon is a dummy to handle browser favicon requests without warnings
func (svc *ServiceContext) ignoreFavicon(c *gin.Context) {
}

// GetVersion reports the version of the serivce
func (svc *ServiceContext) getVersion(c *gin.Context) {
	build := "unknown"
	// working directory is the bin directory, and build tag is in the root
	files, _ := filepath.Glob("../buildtag.*")
	if len(files) == 1 {
		build = strings.Replace(files[0], "../buildtag.", "", 1)
	}

	vMap := make(map[string]string)
	vMap["version"] = svc.Version
	vMap["build"] = build
	c.JSON(http.StatusOK, vMap)
}

// HealthCheck reports the health of the serivce
func (svc *ServiceContext) healthCheck(c *gin.Context) {
	type hcResp struct {
		Healthy bool   `json:"healthy"`
		Message string `json:"message,omitempty"`
	}
	hcMap := make(map[string]hcResp)
	hcMap["apiservice"] = hcResp{Healthy: true}

	err := svc.DB.DB().Ping()
	if err != nil {
		hcMap["database"] = hcResp{Healthy: false, Message: err.Error()}
	} else {
		hcMap["database"] = hcResp{Healthy: true}
	}

	c.JSON(http.StatusOK, hcMap)
}

func (svc *ServiceContext) getStyleSheet(c *gin.Context) {
	ssID := strings.ToLower(c.Param("id"))
	log.Printf("Get Stylesheet %s", ssID)
	c.Header("Content-Type", "text/xml")

	if ssID == "default" {
		c.File("./xsl/defaultModsTransformation.xsl")
		return
	}
	if ssID == "holsinger" {
		c.File("./xsl/holsingerTransformation.xsl")
		return
	}
	if ssID == "marctomods" {
		c.File("./xsl/MARC21slim2MODS3-6_rev_no_include.xsl")
		return
	}
	if ssID == "fixmarc" {
		c.File("./xsl/fixMarcErrors_no_include.xsl")
		return
	}
	tgt := fmt.Sprintf("./xslt/%s.xsl", ssID)
	if _, err := os.Stat(tgt); err == nil {
		c.File(tgt)
		return
	}

	c.Header("Content-Type", "text/plain")
	c.String(http.StatusNotFound, "not found")
}
