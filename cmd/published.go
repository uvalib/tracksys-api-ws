package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
)

func (svc *ServiceContext) getPublishedDPLA(c *gin.Context) {
	out := make([]string, 0)
	query := `
	select distinct mc.pid as pid from metadata mc
	inner join metadata mp on mc.parent_metadata_id = mp.id
	where
		mc.parent_metadata_id > 0 and mp.dpla = 1 and mp.date_dl_ingest is not null and
		mc.dpla = 1 and mc.date_dl_ingest is not null
	order by mp.pid asc`
	count := 0
	q := svc.DB.NewQuery(query)
	rows, err := q.Rows()
	if err != nil {
		if err != sql.ErrNoRows {
			log.Printf("ERROR: unable to get DPLA collections info: %s", err.Error())
			c.String(http.StatusInternalServerError, err.Error())
			return
		}
		log.Printf("WARNING: DPLA collections info not found")
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

	log.Printf("INFO: found %d DPLA items in collections", count)

	// Now get stand-alone DPLA flagged metadata and generate the records
	query = `select distinct m.pid from metadata m
	where parent_metadata_id = 0 and dpla = 1 and date_dl_ingest is not null
	order by m.pid asc`
	q = svc.DB.NewQuery(query)
	count = 0
	rows, err = q.Rows()
	if err != nil {
		if err != sql.ErrNoRows {
			log.Printf("ERROR: unable to get standalone DPLA items: %s", err.Error())
			c.String(http.StatusInternalServerError, err.Error())
			return
		}
		log.Printf("WARNING: standalone DPLA items not found")
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
	log.Printf("INFO: found %d standalone DPLA items", count)
	log.Printf("INFO: total DPLA items found: %d", len(out))

	c.String(http.StatusOK, strings.Join(out, ", "))
}

func (svc *ServiceContext) getPublishedVirgo(c *gin.Context) {
	pubType := strings.ToLower(c.Query("type"))
	if pubType == "" {
		log.Printf("ERROR: invalid request for virgo published items without a type param")
		c.String(http.StatusBadRequest, "type param is required")
		return
	}

	if pubType != "other" && pubType != "sirsi" {
		log.Printf("WARNING: unsupported publication type: %s", pubType)
		c.String(http.StatusBadRequest, fmt.Sprintf("type %s is not supported", pubType))
		return
	}

	type publishedPIDs struct {
		Total   int      `json:"total"`
		ItemIDs []string `json:"items"`
	}

	excludeKeys := make([]string, 0)
	query := `select distinct catalog_key from metadata m
		inner join units u on u.metadata_id = m.id
		where date_dl_ingest is not null and type = 'SirsiMetadata' and catalog_key <> '' and u.include_in_dl=1;`
	if pubType == "other" {
		query = `select distinct pid from metadata where date_dl_ingest is not null and type = 'XmlMetadata'`
	} else {
		// exclude DPLA collection records
		log.Printf("INFO: get a list of DPLA collection records that should be excluded")
		excludeSQL := `select distinct mp.catalog_key from metadata mc
		inner join metadata mp on mc.parent_metadata_id = mp.id
		where mc.parent_metadata_id > 0 and mp.dpla = 1 and mp.date_dl_ingest is not null
		and mp.catalog_key is not null and mp.catalog_key != 'test'`
		q := svc.DB.NewQuery(excludeSQL)
		rows, err := q.Rows()
		if err != nil {
			if err != sql.ErrNoRows {
				log.Printf("ERROR: unable to get collection cat keys: %s", err.Error())
				c.String(http.StatusInternalServerError, err.Error())
				return
			}
			log.Printf("WARNING: collection cat keys not found")
		} else {
			for rows.Next() {
				var ck string
				re := rows.Scan(&ck)
				if re == nil {
					excludeKeys = append(excludeKeys, ck)
				}
			}
		}
	}
	q := svc.DB.NewQuery(query)
	rows, err := q.Rows()
	if err != nil {
		if err != sql.ErrNoRows {
			log.Printf("ERROR: unable to get virgo-published %s items: %s", pubType, err.Error())
			c.String(http.StatusInternalServerError, err.Error())
			return
		}
		log.Printf("WARNING: virgo-published %s items not found", pubType)
	}

	out := publishedPIDs{ItemIDs: make([]string, 0)}
	for rows.Next() {
		var catKey string
		re := rows.Scan(&catKey)
		if re == nil {
			if !contains(excludeKeys, catKey) {
				out.ItemIDs = append(out.ItemIDs, catKey)
			}
		}
	}
	out.Total = len(out.ItemIDs)
	log.Printf("INFO: found %d %s items published to virgo", out.Total, pubType)
	c.JSON(http.StatusOK, out)
}

func contains(array []string, item string) bool {
	for _, a := range array {
		if a == item {
			return true
		}
	}
	return false
}
