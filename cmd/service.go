package main

import (
	"errors"
	"fmt"
	"io/ioutil"
	"log"
	"net"
	"net/http"
	"net/url"
	"os"
	"path"
	"path/filepath"
	"strconv"
	"strings"
	"sync"
	"time"

	"github.com/gin-gonic/gin"
	_ "github.com/go-sql-driver/mysql"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

// CacheRecord contains mods/uvamap/dpla results that are temporarily cached
// This is necessary for many metadata requests ast they require multi-step transforms
// with each depending upon the results of the last. Entries are short lived; 1 minute
type CacheRecord struct {
	Data      []byte
	ExpiresAt time.Time
}

// Cache is a simple map of string -> []byte for metad records
type Cache struct {
	Data map[string]CacheRecord
	Mux  sync.Mutex
}

// ServiceContext contains common data used by all handlers
type ServiceContext struct {
	Version       string
	APIURL        string
	SirsiURL      string
	SaxonURL      string
	TrackSysURL   string
	PDFServiceURL string
	IIIFManURL    string
	IIIFURL       string
	GDB           *gorm.DB
	HTTPClient    *http.Client
	SaxonClient   *http.Client
	Cache         Cache
	WorkDir       string
	Key           string
}

// InitializeService sets up the service context for all API handlers
func InitializeService(version string, cfg *ServiceConfig) *ServiceContext {
	ctx := ServiceContext{Version: version,
		APIURL:        cfg.APIURL,
		SirsiURL:      cfg.SirsiURL,
		SaxonURL:      cfg.SaxonURL,
		TrackSysURL:   cfg.TrackSysURL,
		PDFServiceURL: cfg.PDFServiceURL,
		IIIFManURL:    cfg.IIIFManURL,
		IIIFURL:       cfg.IIIFURL,
		WorkDir:       cfg.WorkDir,
		Key:           cfg.WriteKey,
	}
	go ctx.startCache()

	log.Printf("INFO: connecting to DB...")
	connectStr := fmt.Sprintf("%s:%s@tcp(%s)/%s?parseTime=true",
		cfg.DB.User, cfg.DB.Pass, cfg.DB.Host, cfg.DB.Name)
	gdb, err := gorm.Open(mysql.Open(connectStr), &gorm.Config{})
	if err != nil {
		log.Fatal(err)
	}
	log.Printf("INFO: configure db pool settings...")
	sqlDB, _ := gdb.DB()
	sqlDB.SetConnMaxLifetime(5 * time.Minute)
	sqlDB.SetMaxIdleConns(10)
	sqlDB.SetMaxOpenConns(10)
	ctx.GDB = gdb
	log.Printf("INFO: DB Connection established")

	log.Printf("INFO: create HTTP Client...")
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
	ctx.SaxonClient = &http.Client{
		Transport: defaultTransport,
		Timeout:   30 * time.Second,
	}
	log.Printf("INFO: HTTP Client created")

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

	hcMap["database"] = hcResp{Healthy: true}
	sqlDB, err := svc.GDB.DB()
	if err != nil {
		hcMap["database"] = hcResp{Healthy: false, Message: err.Error()}
	} else {
		err := sqlDB.Ping()
		if err != nil {
			hcMap["database"] = hcResp{Healthy: false, Message: err.Error()}
		}
	}

	c.JSON(http.StatusOK, hcMap)
}

func (svc *ServiceContext) describeService(c *gin.Context) {
	c.Header("Content-Type", "application/json")
	c.File("./templates/describe.json")
}

func (svc *ServiceContext) getExemplarThumbURL(mdID int64) (string, error) {
	log.Printf("INFO: get thumb url for metadata id %d", mdID)
	exemplarURL := ""
	var mf masterFile
	mfResp := svc.GDB.Preload("ImageTechMeta").Where("metadata_id=? and exemplar=1", mdID).First(&mf)
	if mfResp.Error != nil {
		if errors.Is(mfResp.Error, gorm.ErrRecordNotFound) == false {
			return "", mfResp.Error
		}
		log.Printf("INFO: no exemplar set for metadata id %d; choosing first masterfile", mdID)
		mfResp = svc.GDB.Where("metadata_id=?", mdID).Order("filename asc").First(&mf)
		if mfResp.Error != nil {
			return "", mfResp.Error
		}
	}

	// If ClonedFromID is set, this MF is cloned. Must use original MF for exemplar
	if mf.ClonedFrom != 0 {
		log.Printf("INFO: thumb masterfile %s is a clone; look up original", mf.PID)
		mfResp := svc.GDB.Preload("ImageTechMeta").Find(&mf, mf.ClonedFrom)
		if mfResp.Error != nil {
			log.Printf("ERROR: exemplar for %d is a clone, and original %d could not be found: %s",
				mdID, mf.ClonedFrom, mfResp.Error.Error())
			return "", mfResp.Error
		}
	}

	// orientation is enum type: none: 0, flip_y_axis: 1, rotate90: 2, rotate180: 3, rotate270
	rotations := []string{"0", "!0", "90", "180", "270"}
	exemplarURL = fmt.Sprintf("%s/%s/full/!125,200/%s/default.jpg", svc.IIIFURL, mf.PID, rotations[mf.ImageTechMeta.Orientation])

	return exemplarURL, nil
}

func (svc *ServiceContext) saxonTransform(payload *url.Values) ([]byte, error) {
	log.Printf("INFO: POST to SaxonServlet %v", payload)
	req, _ := http.NewRequest("POST", svc.SaxonURL, strings.NewReader(payload.Encode()))
	req.Header.Add("Content-Type", "application/x-www-form-urlencoded")
	req.Header.Add("Content-Length", strconv.Itoa(len(payload.Encode())))
	startTime := time.Now()
	resp, rawErr := svc.SaxonClient.Do(req)
	elapsedNanoSec := time.Since(startTime)
	elapsedMS := int64(elapsedNanoSec / time.Millisecond)
	bodyBytes, err := handleAPIResponse(svc.SaxonURL, resp, rawErr)
	if err != nil {
		// Don't log the error, its just a messy blob of HTML with no useful info
		log.Printf("ERROR: SaxonTransform failed. Elapsed Time: %d (ms)", elapsedMS)
		return nil, err
	}

	log.Printf("INFO: successful response from SaxonTransform. Elapsed Time: %d (ms)", elapsedMS)
	return bodyBytes, nil
}

func (svc *ServiceContext) getAPIResponse(url string) ([]byte, error) {
	log.Printf("INFO: GET API Response from %s, timeout  %.0f sec", url, svc.HTTPClient.Timeout.Seconds())
	req, _ := http.NewRequest("GET", url, nil)
	req.Header.Add("User-Agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.128 Safari/537.36")

	startTime := time.Now()
	resp, rawErr := svc.HTTPClient.Do(req)
	elapsedNanoSec := time.Since(startTime)
	elapsedMS := int64(elapsedNanoSec / time.Millisecond)
	bodyBytes, err := handleAPIResponse(url, resp, rawErr)
	if err != nil {
		log.Printf("ERROR: %s : %s. Elapsed Time: %d (ms)", url, err.Error(), elapsedMS)
		return nil, err
	}

	log.Printf("INFO: successful response from %s. Elapsed Time: %d (ms)", url, elapsedMS)
	return bodyBytes, nil
}

func handleAPIResponse(url string, resp *http.Response, rawErr error) ([]byte, error) {
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
		return nil, err
	} else if resp.StatusCode != http.StatusOK && resp.StatusCode != http.StatusCreated {
		defer resp.Body.Close()
		bodyBytes, _ := ioutil.ReadAll(resp.Body)
		status := resp.StatusCode
		errMsg := string(bodyBytes)
		err := fmt.Errorf("%d: %s", status, errMsg)
		return nil, err
	}

	defer resp.Body.Close()
	bodyBytes, _ := ioutil.ReadAll(resp.Body)
	return bodyBytes, nil
}

func (svc *ServiceContext) getStyleSheet(c *gin.Context) {
	ssID := strings.ToLower(c.Param("id"))
	log.Printf("INFO: get stylesheet %s", ssID)
	c.Header("Content-Type", "text/xml")

	if ssID == "marctomods" {
		c.File("./xsl/MARC21slim2MODS3-6_rev_no_include.xsl")
		return
	}
	if ssID == "modstouvamap" {
		c.File("./xsl/mods2uvaMAP_no_include.xsl")
		return
	}
	if ssID == "uvamaptodpla" {
		c.File("./xsl/uvaMap2DPLA_no_include.xsl")
		return
	}
	if ssID == "fixmarc" {
		c.File("./xsl/fixMarcErrors_no_include.xsl")
		return
	}

	xslFilePath := path.Join(svc.WorkDir, ssID)
	_, existErr := os.Stat(xslFilePath)
	if existErr == nil {
		c.File(xslFilePath)
		return
	}

	log.Printf("ERROR: stylesheet %s not found", ssID)
	c.Header("Content-Type", "text/plain")
	c.String(http.StatusNotFound, "not found")
}
