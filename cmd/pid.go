package main

import (
	"log"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
	dbx "github.com/go-ozzo/ozzo-dbx"
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

	// First try metadata
	sql := `select type,e.name as ext_system from metadata m left outer join external_systems e
		on e.id = m.external_system_id where pid={:pid}`
	q := svc.DB.NewQuery(sql)
	q.Bind(dbx.Params{"pid": pid})
	var resp struct {
		Type   string  `db:"type"`
		System *string `db:"ext_system"`
	}
	err := q.One(&resp)
	if err == nil {
		if resp.Type == "SirsiMetadata" {
			c.String(http.StatusOK, "sirsi_metadata")
		} else if resp.Type == "XmlMetadata" {
			c.String(http.StatusOK, "xml_metadata")
		} else if resp.Type == "ExternalMetadata" && resp.System != nil && *resp.System == "ArchivesSpace" {
			c.String(http.StatusOK, "archivesspace_metadata")
		} else if resp.Type == "ExternalMetadata" && resp.System != nil && *resp.System == "Apollo" {
			c.String(http.StatusOK, "apollo_metadata")
		} else if resp.Type == "ExternalMetadata" && resp.System != nil && *resp.System == "JSTOR Forum" {
			c.String(http.StatusOK, "jstor_metadata")
		} else {
			c.String(http.StatusInternalServerError, "unknown metadata type")
		}
		return
	}

	// see if it is a component...
	var ID uint64
	q = svc.DB.NewQuery(`select id from components where pid={:pid}`)
	q.Bind(dbx.Params{"pid": pid})
	err = q.Row(&ID)
	if err == nil {
		c.String(http.StatusOK, "component")
		return
	}

	// last chance... master file?
	q = svc.DB.NewQuery(`select id from master_files where pid={:pid}`)
	q.Bind(dbx.Params{"pid": pid})
	err = q.Row(&ID)
	if err == nil {
		c.String(http.StatusOK, "masterfile")
		return
	}

	log.Printf("ERROR: unable to find PID %s: %s", pid, err.Error())
	c.String(http.StatusNotFound, "not found")
}

func (svc *ServiceContext) getPIDRights(c *gin.Context) {
	pid := c.Param("pid")
	log.Printf("Get rights for %s", pid)
	q := svc.DB.NewQuery(`select id,availability_policy_id from metadata where pid={:pid}`)
	q.Bind(dbx.Params{"pid": pid})
	var resp struct {
		ID      int64  `db:"id"`
		AvailID *int64 `db:"availability_policy_id"`
	}
	err := q.One(&resp)
	if err != nil {
		sql := `select f.id,availability_policy_id from master_files f
			inner join metadata m on m.id = f.metadata_id
			inner join availability_policies a on a.id = m.availability_policy_id
			where f.pid={:pid}`
		q = svc.DB.NewQuery(sql)
		q.Bind(dbx.Params{"pid": pid})
		err = q.One(&resp)
		if err != nil {
			log.Printf("Unable to find %s: %s", pid, err.Error())
			c.String(http.StatusNotFound, "not found")
			return
		}
	}

	if resp.AvailID == nil {
		c.String(http.StatusOK, "private")
		return
	}
	q = svc.DB.NewQuery("select name from availability_policies where id={:id}")
	q.Bind(dbx.Params{"id": resp.AvailID})
	var rights string
	err = q.Row(&rights)
	if err == nil {
		c.String(http.StatusOK, strings.ToLower(strings.Split(rights, " ")[0]))
		return
	}

	c.String(http.StatusNotFound, "not found")
}
