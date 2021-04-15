package main

import (
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
)

func (svc *ServiceContext) getPIDSummary(c *gin.Context) {
	pid := c.Param("pid")
	log.Printf("Get summary for %s", pid)
	c.String(http.StatusNotImplemented, "not yet")
}

func (svc *ServiceContext) getPIDText(c *gin.Context) {
	pid := c.Param("pid")
	log.Printf("Get full text for %s", pid)
	c.String(http.StatusNotImplemented, "not yet")
}

func (svc *ServiceContext) getPIDType(c *gin.Context) {
	pid := c.Param("pid")
	log.Printf("Get type for %s", pid)
	c.String(http.StatusNotImplemented, "not yet")
}

func (svc *ServiceContext) getPIDRights(c *gin.Context) {
	pid := c.Param("pid")
	log.Printf("Get rights for %s", pid)
	c.String(http.StatusNotImplemented, "not yet")
}
