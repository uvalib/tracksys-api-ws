package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net"
	"net/http"
	"net/url"
	"path/filepath"
	"strconv"
	"strings"
	"time"

	"github.com/gin-gonic/gin"
	dbx "github.com/go-ozzo/ozzo-dbx"
	_ "github.com/go-sql-driver/mysql"
)

// ServiceContext contains common data used by all handlers
type ServiceContext struct {
	Version       string
	APIURL        string
	SirsiURL      string
	SaxonURL      string
	PDFServiceURL string
	IIIFManURL    string
	IIIFURL       string
	DB            *dbx.DB
	HTTPClient    *http.Client
	Cache         map[string]*[]byte
}

type cloneData struct {
	ID       int64  `db:"id"`
	PID      string `json:"pid"`
	Filename string `json:"filename"`
}

// InitializeService sets up the service context for all API handlers
func InitializeService(version string, cfg *ServiceConfig) *ServiceContext {
	ctx := ServiceContext{Version: version,
		APIURL:        cfg.APIURL,
		SirsiURL:      cfg.SirsiURL,
		SaxonURL:      cfg.SaxonURL,
		PDFServiceURL: cfg.PDFServiceURL,
		IIIFManURL:    cfg.IIIFManURL,
		IIIFURL:       cfg.IIIFURL,
	}
	ctx.Cache = make(map[string]*[]byte)

	log.Printf("INFO: connecting to DB...")
	connectStr := fmt.Sprintf("%s:%s@tcp(%s)/%s?parseTime=true",
		cfg.DB.User, cfg.DB.Pass, cfg.DB.Host, cfg.DB.Name)
	db, err := dbx.Open("mysql", connectStr)
	if err != nil {
		log.Fatal(err)
	}
	ctx.DB = db
	db.LogFunc = log.Printf
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

	err := svc.DB.DB().Ping()
	if err != nil {
		hcMap["database"] = hcResp{Healthy: false, Message: err.Error()}
	} else {
		hcMap["database"] = hcResp{Healthy: true}
	}

	c.JSON(http.StatusOK, hcMap)
}

func (svc *ServiceContext) describeService(c *gin.Context) {
	c.Header("Content-Type", "application/json")
	c.File("./templates/describe.json")
}

func (svc *ServiceContext) getOriginalMasterFile(mfID int64) (*cloneData, error) {
	log.Printf("INFO: lookup original masterfile %d for clone", mfID)
	q := svc.DB.NewQuery("select id,pid,filename from master_files where id={:id}")
	q.Bind(dbx.Params{"id": mfID})
	var clonedFrom cloneData
	err := q.One(&clonedFrom)
	if err != nil {
		return nil, err
	}
	return &clonedFrom, nil
}

func (svc *ServiceContext) getExemplarThumbURL(mdID int64) string {
	exemplarURL := ""
	sql := `select id,pid,original_mf_id from master_files where metadata_id={:id} and exemplar=1 limit 1`
	q := svc.DB.NewQuery(sql)
	q.Bind(dbx.Params{"id": mdID})

	var mf struct {
		ID           int64  `db:"id"`
		PID          string `db:"pid"`
		ClonedFromID *int64 `db:"original_mf_id"`
	}
	err := q.One(&mf)
	if err != nil {
		log.Printf("WARNING: unable to find exemplar for %d: %s", mdID, err.Error())
		return exemplarURL
	}

	// If ClonedFromID is set, this MF is cloned. Must use original MF for exemplar
	if mf.ClonedFromID != nil {
		q := svc.DB.NewQuery(sql)
		q.Bind(dbx.Params{"id": *mf.ClonedFromID})
		err := q.One(&mf)
		if err != nil {
			log.Printf("WARNING: unable to find original exemplar for %d: %s", mdID, err.Error())
			return exemplarURL
		}
	}

	// orientation is enum type: none: 0, flip_y_axis: 1, rotate90: 2, rotate180: 3, rotate270
	sql = `select orientation from image_tech_meta where master_file_id={:id} limit 1`
	q = svc.DB.NewQuery(sql)
	orientationID := 0
	rotations := []string{"0", "!0", "90", "180", "270"}
	q.Bind(dbx.Params{"id": mf.ID})
	q.Row(&orientationID)
	exemplarURL = fmt.Sprintf("%s/%s/full/!125,200/%s/default.jpg", svc.IIIFURL, mf.PID, rotations[orientationID])

	return exemplarURL
}

func (svc *ServiceContext) saxonTransform(payload *url.Values) ([]byte, error) {
	log.Printf("INFO: POST to SaxonServlet to transform %v", payload)
	req, _ := http.NewRequest("POST", svc.SaxonURL, strings.NewReader(payload.Encode()))
	req.Header.Add("Content-Type", "application/x-www-form-urlencoded")
	req.Header.Add("Content-Length", strconv.Itoa(len(payload.Encode())))
	startTime := time.Now()
	resp, rawErr := svc.HTTPClient.Do(req)
	elapsedNanoSec := time.Since(startTime)
	elapsedMS := int64(elapsedNanoSec / time.Millisecond)
	bodyBytes, err := handleAPIResponse(svc.SaxonURL, resp, rawErr)
	if err != nil {
		log.Printf("ERROR: SaxonTransform failed: %s. Elapsed Time: %d (ms)", err.Error(), elapsedMS)
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
