package main

import (
	"fmt"
	"log"

	"github.com/gin-contrib/cors"
	"github.com/gin-contrib/gzip"
	"github.com/gin-gonic/gin"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
	ginprometheus "github.com/zsais/go-gin-prometheus"
)

// Version of the service
const version = "2.0.6"

func main() {
	log.Printf("===> TrackSys API service starting up <===")

	// Get config params and use them to init service context. Any issues are fatal
	cfg := LoadConfiguration()
	svc := InitializeService(version, cfg)

	log.Printf("INFO: setup routes...")
	gin.SetMode(gin.ReleaseMode)
	gin.DisableConsoleColor()
	router := gin.Default()
	router.Use(gzip.Gzip(gzip.DefaultCompression))
	corsCfg := cors.DefaultConfig()
	corsCfg.AllowAllOrigins = true
	corsCfg.AllowCredentials = true
	corsCfg.AddAllowHeaders("Authorization")
	router.Use(cors.New(corsCfg))
	p := ginprometheus.NewPrometheus("gin")

	// roundabout setup of /metrics endpoint to avoid double-gzip of response
	router.Use(p.HandlerFunc())
	h := promhttp.InstrumentMetricHandler(prometheus.DefaultRegisterer, promhttp.HandlerFor(prometheus.DefaultGatherer, promhttp.HandlerOpts{DisableCompression: true}))

	router.GET(p.MetricsPath, func(c *gin.Context) {
		h.ServeHTTP(c.Writer, c.Request)
	})

	router.GET("/", svc.getVersion)
	router.GET("/favicon.ico", svc.ignoreFavicon)
	router.GET("/version", svc.getVersion)
	router.GET("/healthcheck", svc.healthCheck)
	router.GET("/describe", svc.describeService)
	api := router.Group("/api")
	{
		api.GET("/circulation", svc.getCirculationData)
		api.GET("/manifest/:pid", svc.getManifest)

		api.GET("/published/dpla", svc.getPublishedDPLA)
		api.GET("/published/virgo", svc.getPublishedVirgo)

		api.GET("/enriched/other/:pid", svc.getEnrichedOtherMetadata)
		api.GET("/enriched/sirsi/:key", svc.getEnrichedSirsiMetadata)

		api.GET("/stylesheet/:id", svc.getStyleSheet)

		api.GET("/pid/:pid", svc.getPIDSummary)
		api.GET("/pid/:pid/access", svc.getPIDAccess)
		api.GET("/pid/:pid/type", svc.getPIDType)
		api.GET("/pid/:pid/text", svc.getPIDText)

		api.GET("/metadata/:pid", svc.getMetadata)
		api.GET("/search", svc.searchMetadata)
	}

	portStr := fmt.Sprintf(":%d", cfg.Port)
	log.Printf("INFO: start service v%s on port %s", version, portStr)
	log.Fatal(router.Run(portStr))
}
