package main

import (
	"errors"
	"fmt"
	"log"
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func (svc *ServiceContext) getPublishedDPLA(c *gin.Context) {
	out := make([]string, 0)
	var mdRecs []metadata
	dbResp := svc.GDB.Distinct("metadata.pid").Select("metadata.pid").
		Joins("inner join metadata mp on metadata.parent_metadata_id = mp.id").
		Where("metadata.parent_metadata_id > 0 and mp.dpla = 1 and mp.date_dl_ingest is not null and metadata.dpla = 1 and metadata.date_dl_ingest is not null").
		Order("mp.pid asc").Find(&mdRecs)

	if dbResp.Error != nil {
		if errors.Is(dbResp.Error, gorm.ErrRecordNotFound) == false {
			log.Printf("ERROR: unable to get DPLA collections info: %s", dbResp.Error.Error())
			c.String(http.StatusInternalServerError, dbResp.Error.Error())
			return
		}
		log.Printf("WARNING: DPLA collections info not found")
	}
	for _, r := range mdRecs {
		out = append(out, r.PID)
	}
	log.Printf("INFO: found %d DPLA items in collections", dbResp.RowsAffected)

	// Now get stand-alone DPLA flagged metadata and generate the records
	dbResp = svc.GDB.Distinct("metadata.pid").Select("metadata.pid").
		Where("parent_metadata_id = 0 and dpla = 1 and date_dl_ingest is not null").
		Order("pid asc").Find(&mdRecs)
	if dbResp.Error != nil {
		if errors.Is(dbResp.Error, gorm.ErrRecordNotFound) == false {
			log.Printf("ERROR: unable to get standalone DPLA items: %s", dbResp.Error.Error())
			c.String(http.StatusInternalServerError, dbResp.Error.Error())
			return
		}
		log.Printf("WARNING: standalone DPLA items not found")
	}
	for _, r := range mdRecs {
		out = append(out, r.PID)
	}
	log.Printf("INFO: found %d standalone DPLA items", dbResp.RowsAffected)

	log.Printf("INFO: found %d TOTAL DPLA items", len(out))
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

	var mdRecs []metadata
	var dbResp *gorm.DB
	excludeKeys := make([]string, 0)
	if pubType == "other" {
		dbResp = svc.GDB.Distinct("metadata.pid").Select("metadata.pid").
			Where("date_dl_ingest is not null and type = ?", "XmlMetadata").
			Find(&mdRecs)
	} else {
		log.Printf("INFO: get a list of DPLA collection records that should be excluded")
		var excludeRecs []metadata
		exResp := svc.GDB.Distinct("mp.catalog_key").Select("mp.catalog_key").
			Joins("inner join metadata mp on metadata.parent_metadata_id = mp.id").
			Where("metadata.parent_metadata_id > 0 and mp.dpla = 1 and mp.date_dl_ingest is not null and mp.catalog_key is not null and mp.catalog_key != ?", "test").
			Find(&excludeRecs)
		if exResp.Error != nil {
			if errors.Is(exResp.Error, gorm.ErrRecordNotFound) == false {
				log.Printf("ERROR: unable to get collection cat keys: %s", exResp.Error.Error())
				c.String(http.StatusInternalServerError, exResp.Error.Error())
				return
			}
			log.Printf("WARNING: collection cat keys not found")
		}
		for _, r := range excludeRecs {
			excludeKeys = append(excludeKeys, r.CatalogKey)
		}
		log.Printf("INFO: excluded: %v", excludeKeys)

		dbResp = svc.GDB.Distinct("catalog_key").Select("catalog_key").
			Joins("inner join units u on u.metadata_id = metadata.id").
			Where("date_dl_ingest is not null and type = ? and catalog_key <> ? and u.include_in_dl=1", "SirsiMetadata", "").
			Find(&mdRecs)
	}

	if dbResp.Error != nil {
		if errors.Is(dbResp.Error, gorm.ErrRecordNotFound) == false {
			log.Printf("ERROR: unable to get virgo-published %s items: %s", pubType, dbResp.Error.Error())
			c.String(http.StatusInternalServerError, dbResp.Error.Error())
			return
		}
		log.Printf("WARNING: virgo-published %s items not found", pubType)
	}

	out := publishedPIDs{ItemIDs: make([]string, 0)}
	for _, r := range mdRecs {
		if pubType == "other" {
			out.ItemIDs = append(out.ItemIDs, r.PID)
		} else {
			if !contains(excludeKeys, r.CatalogKey) {
				out.ItemIDs = append(out.ItemIDs, r.CatalogKey)
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
