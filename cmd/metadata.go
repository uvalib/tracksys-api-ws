package main

import (
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
)

func (svc *ServiceContext) getMetadata(c *gin.Context) {
	pid := c.Param("pid")
	mdType := c.Query("type")
	if mdType == "" {
		c.String(http.StatusBadRequest, "type is required")
		return
	}
	log.Printf("Get %s metadata for %s", mdType, pid)
	c.String(http.StatusNotImplemented, "not yet")
}
