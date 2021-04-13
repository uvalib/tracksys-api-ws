package main

import (
	"fmt"
	"log"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
)

func (svc *ServiceContext) getPublishedDPLA(c *gin.Context) {
	out := make([]string, 0)
	sql := `
	select distinct mc.pid as pid from metadata mc
	inner join metadata mp on mc.parent_metadata_id = mp.id
	where
		mc.parent_metadata_id > 0 and mp.dpla = 1 and mp.date_dl_ingest is not null and
		mc.dpla = 1 and mc.date_dl_ingest is not null
	order by mp.pid asc`
	count := 0
	q := svc.DB.NewQuery(sql)
	rows, err := q.Rows()
	if err != nil {
		log.Printf("ERROR: unable to get DPLA collections info: %s", err.Error())
	} else {
		for rows.Next() {
			var pidRow string
			re := rows.Scan(&pidRow)
			if re == nil {
				out = append(out, pidRow)
				count++
			}
		}
	}

	log.Printf("Found %d DPLA items in collections", count)

	// Now get stand-alone DPLA flagged metadata and generate the records
	sql = `select distinct m.pid from metadata m
	where parent_metadata_id = 0 and dpla = 1 and date_dl_ingest is not null
	order by m.pid asc`
	q = svc.DB.NewQuery(sql)
	count = 0
	rows, err = q.Rows()
	if err != nil {
		log.Printf("ERROR: unable to get standalone DPLA items: %s", err.Error())
	} else {
		for rows.Next() {
			var pidRow string
			re := rows.Scan(&pidRow)
			if re == nil {
				out = append(out, pidRow)
				count++
			}
		}
	}
	log.Printf("Found %d standalone DPLA items", count)
	log.Printf("TOTAL DPLA items found: %d", len(out))

	c.String(http.StatusOK, strings.Join(out, ", "))
}

func (svc *ServiceContext) getPublishedVirgo(c *gin.Context) {
	pubType := strings.ToLower(c.Query("type"))
	if pubType == "" {
		log.Printf("Invalid request for virgo published items without a type param")
		c.String(http.StatusBadRequest, "type param is required")
		return
	}

	if pubType != "other" && pubType != "sirsi" {
		log.Printf("Unknown publication type: %s", pubType)
		c.String(http.StatusBadRequest, fmt.Sprintf("type %s is not supported", pubType))
		return
	}

	type publishedPIDs struct {
		ItemIDs []string `json:"items"`
	}

	sql := `select distinct catalog_key from metadata where date_dl_ingest is not null and type = 'SirsiMetadata'`
	if pubType == "other" {
		sql = `select distinct pid from metadata where date_dl_ingest is not null and type = 'XmlMetadata'`
	}
	q := svc.DB.NewQuery(sql)
	rows, err := q.Rows()
	if err != nil {
		log.Printf("ERROR: unable to get virgo-published %s items: %s", pubType, err.Error())
		return
	}

	out := publishedPIDs{ItemIDs: make([]string, 0)}
	for rows.Next() {
		var pidRow string
		re := rows.Scan(&pidRow)
		if re == nil {
			out.ItemIDs = append(out.ItemIDs, pidRow)
		}
	}
	log.Printf("Found %d %s items published to virgo", len(out.ItemIDs), pubType)
	c.JSON(http.StatusOK, out)
}
