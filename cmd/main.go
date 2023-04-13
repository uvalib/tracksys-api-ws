package main

import (
	"fmt"
	"log"

	"github.com/gin-contrib/cors"
	"github.com/gin-contrib/gzip"
	"github.com/gin-gonic/gin"
)

// Version of the service
const version = "2.8.2"

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

	router.GET("/", svc.getVersion)
	router.GET("/favicon.ico", svc.ignoreFavicon)
	router.GET("/version", svc.getVersion)
	router.GET("/healthcheck", svc.healthCheck)
	router.GET("/describe", svc.describeService)
	api := router.Group("/api")
	{
		api.GET("/circulation", svc.getCirculationData)
		api.GET("/manifest/:pid", svc.getManifest)

		api.GET("/aptrust", svc.getApTrustReport)

		api.GET("/published/dpla", svc.getPublishedDPLA)
		api.GET("/published/virgo", svc.getPublishedVirgo)

		api.GET("/report/archivesspace", svc.getArchivesSpaceReport)

		api.GET("/enriched/other/:pid", svc.getEnrichedOtherMetadata)
		api.GET("/enriched/sirsi/:key", svc.getEnrichedSirsiMetadata)

		api.GET("/stylesheet/:id", svc.getStyleSheet)

		api.GET("/pid/:pid", svc.getPIDSummary)
		api.GET("/pid/:pid/type", svc.getPIDType)
		api.GET("/pid/:pid/text", svc.getPIDText)
		api.POST("/pid/:pid/ocr", svc.updatePIDText)

		api.GET("/metadata/:pid", svc.getMetadata)
		api.DELETE("/metadata/cache", svc.clearMetadataCache)

		api.POST("/transform", svc.transformXMLMetadata)
		api.GET("/transform/:id/status", svc.transformStatus)
	}

	portStr := fmt.Sprintf(":%d", cfg.Port)
	log.Printf("INFO: start service v%s on port %s", version, portStr)
	log.Fatal(router.Run(portStr))
}
