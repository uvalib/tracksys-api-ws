package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net"
	"net/http"
	"path/filepath"
	"strings"
	"time"

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
	HTTPClient    *http.Client
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

	log.Printf("Create HTTP Client...")
	defaultTransport := &http.Transport{
		Proxy: http.ProxyFromEnvironment,
		DialContext: (&net.Dialer{
			Timeout:   5 * time.Second,
			KeepAlive: 600 * time.Second,
		}).DialContext,
		ForceAttemptHTTP2:     true,
		MaxIdleConns:          100,
		MaxIdleConnsPerHost:   100,
		IdleConnTimeout:       90 * time.Second,
		TLSHandshakeTimeout:   10 * time.Second,
		ExpectContinueTimeout: 1 * time.Second,
	}
	ctx.HTTPClient = &http.Client{
		Transport: defaultTransport,
		Timeout:   10 * time.Second,
	}
	log.Printf("HTTP Client created")

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

func (svc *ServiceContext) getAPIResponse(url string) ([]byte, error) {
	log.Printf("GET API Response from %s, timeout  %.0f sec", url, svc.HTTPClient.Timeout.Seconds())
	req, _ := http.NewRequest("GET", url, nil)

	startTime := time.Now()
	resp, rawErr := svc.HTTPClient.Do(req)
	elapsedNanoSec := time.Since(startTime)
	elapsedMS := int64(elapsedNanoSec / time.Millisecond)

	if rawErr != nil {
		status := http.StatusBadRequest
		errMsg := rawErr.Error()
		if strings.Contains(rawErr.Error(), "Timeout") {
			status = http.StatusRequestTimeout
			errMsg = fmt.Sprintf("%s timed out", url)
		} else if strings.Contains(rawErr.Error(), "connection refused") {
			status = http.StatusServiceUnavailable
			errMsg = fmt.Sprintf("%s refused connection", url)
		}
		err := fmt.Errorf("%d: %s", status, errMsg)
		log.Printf("ERROR: %s : %s. Elapsed Time: %d (ms)", url, err.Error(), elapsedMS)
		return nil, err
	} else if resp.StatusCode != http.StatusOK && resp.StatusCode != http.StatusCreated {
		defer resp.Body.Close()
		bodyBytes, _ := ioutil.ReadAll(resp.Body)
		status := resp.StatusCode
		errMsg := string(bodyBytes)
		err := fmt.Errorf("%d: %s", status, errMsg)
		log.Printf("ERROR: %s : %s. Elapsed Time: %d (ms)", url, err.Error(), elapsedMS)
		return nil, err
	}

	defer resp.Body.Close()
	bodyBytes, _ := ioutil.ReadAll(resp.Body)
	log.Printf("Successful response from %s. Elapsed Time: %d (ms)", url, elapsedMS)
	return bodyBytes, nil
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

	c.Header("Content-Type", "text/plain")
	c.String(http.StatusNotFound, "not found")
}
