package main

import (
	"errors"
	"fmt"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type manifestData struct {
	ID          int64      `json:"id"`
	PID         string     `json:"pid"`
	Filename    string     `json:"filename"`
	Width       uint       `json:"width"`
	Height      uint       `json:"height"`
	Title       string     `json:"title,omitempty"`
	Description string     `json:"description,omitempty"`
	TextSource  int64      `json:"text_source,omitempty"`
	Orientation string     `json:"orientation"`
	Exemplar    bool       `json:"exemplar"`
	ClonedFrom  *cloneData `json:"cloned_from,omitempty"`
}

func (svc *ServiceContext) getManifest(c *gin.Context) {
	pid := c.Param("pid")
	var mdInfo metadata

	// First see if the PID is for a metadata record...
	log.Printf("INFO: get manifest for %s", pid)
	dbResp := svc.GDB.Where("pid=?", pid).First(&mdInfo)
	if dbResp.Error == nil {
		log.Printf("INFO: %s is a metadata record", pid)
		unitID := c.Query("unit")
		manifest, err := svc.getMetadataManifest(mdInfo.ID, mdInfo.Type, unitID)
		if err != nil {
			if err.Error() == "no masterfiles found" {
				log.Printf("WARNING: no masterfiles found for metadata %s", pid)
				c.String(http.StatusBadRequest, err.Error())
			} else {
				log.Printf("ERROR: Unable to get manifest for metadata %s: %s", pid, err.Error())
				c.String(http.StatusInternalServerError, err.Error())
			}
		} else {
			c.JSON(http.StatusOK, manifest)
		}
		return
	} else if errors.Is(dbResp.Error, gorm.ErrRecordNotFound) == false {
		log.Printf("ERROR: manifest query to find metadata %s failed: %s", pid, dbResp.Error.Error())
		c.String(http.StatusInternalServerError, dbResp.Error.Error())
		return
	}

	// See if the pid is a component...
	log.Printf("INFO: %s is not a metadata record; trying components", pid)
	var compInfo component
	dbResp = svc.GDB.Where("pid=?", pid).First(&compInfo)
	if dbResp.Error == nil {
		log.Printf("INFO: %s is a component", pid)
		manifest, err := svc.getComponentManifest(compInfo.ID)
		if err != nil {
			log.Printf("ERROR: Unable to get manifest for component %d: %s", compInfo.ID, err.Error())
			c.String(http.StatusInternalServerError, err.Error())
		} else {
			c.JSON(http.StatusOK, manifest)
		}
		return
	} else if errors.Is(dbResp.Error, gorm.ErrRecordNotFound) == false {
		log.Printf("ERROR: manifest query to find compponent %s failed: %s", pid, dbResp.Error.Error())
		c.String(http.StatusInternalServerError, dbResp.Error.Error())
		return
	}

	log.Printf("WARNING: %s not found in database", pid)
	c.String(http.StatusNotFound, fmt.Sprintf("%s not found", pid))
}

func (svc *ServiceContext) getComponentManifest(cID int64) (*[]manifestData, error) {
	var masterFiles []masterFile
	mfResp := svc.GDB.Preload("ImageTechMeta").Where("component_id=?", cID).Find(&masterFiles)
	if mfResp.Error != nil {
		return nil, mfResp.Error
	}
	return svc.generateManifest(&masterFiles)
}

func (svc *ServiceContext) getMetadataManifest(ID int64, mdType string, unitID string) (*[]manifestData, error) {
	log.Printf("INFO: get masterfiles manifest for %s:%d", mdType, ID)
	var out []masterFile
	var mfResp *gorm.DB
	if unitID != "" {
		// important: generally, all master files will have the same metadata aas the unit, but there are common
		// instances where this is not the case. ArchivesSpace and XML metadata records often use only some (or one)
		/// of images from a unit. to make sure onlh the expected images are included, check both unit and metadata
		log.Printf("INFO: only including masterfiles from unit %s", unitID)
		mfResp = svc.GDB.Preload("ImageTechMeta").Where("unit_id=? and metadata_id=?", unitID, ID).Order("filename asc").Find(&out)
	} else if mdType == "ExternalMetadata" {
		// only images from one unit should be included. if there are more, only include images from units that are intended
		// for digital collection building (110) as these are known to be complete and of the highest quality
		log.Printf("INFO: external metadata; including all master files from qualified units")
		var mdUnits []unit
		err := svc.GDB.Debug().Joins("inner join master_files m on m.unit_id = units.id").
			Select("units.id", "units.metadata_id", "units.intended_use_id").
			Where("m.metadata_id=?", ID).Group("units.id").Find(&mdUnits).Error
		if err != nil {
			return nil, err
		}

		if len(mdUnits) == 1 {
			// Only 1 unit present. Assume this is intentional regardless of intended use id and include all images
			mfResp = svc.GDB.Preload("ImageTechMeta").Where("metadata_id=?", ID).Order("filename asc").Find(&out)
		} else {
			if len(mdUnits) == 0 {
				return nil, fmt.Errorf("metadata %d has no units", ID)
			}
			var tgtUnitID int64
			candidateCnt := 0
			for _, u := range mdUnits {
				if u.IntendedUseID == 110 {
					candidateCnt++
					tgtUnitID = u.ID
				}

			}
			if candidateCnt == 0 {
				return nil, fmt.Errorf("no suitable units found")
			}
			if candidateCnt > 1 {
				return nil, fmt.Errorf("multiple candidate units found")
			}
			mfResp = svc.GDB.Preload("ImageTechMeta").Where("metadata_id=? and unit_id=?", ID, tgtUnitID).Order("filename asc").Find(&out)
		}
	} else {
		log.Printf("INFO: only including masterfiles from units in the DL")
		mfResp = svc.GDB.Preload("ImageTechMeta").Joins("inner join units u on u.id = master_files.unit_id").
			Where("master_files.metadata_id=? and u.include_in_dl=1", ID).Order("filename asc").Find(&out)
	}

	if mfResp.Error != nil {
		return nil, mfResp.Error
	}
	return svc.generateManifest(&out)
}

func (svc *ServiceContext) generateManifest(masterFiles *[]masterFile) (*[]manifestData, error) {
	if len(*masterFiles) == 0 {
		return nil, fmt.Errorf("no masterfiles found")
	}
	// take raw master file data and convert into the manifest, including orientation and clone info
	orientations := []string{"normal", "flip_y_axis", "rotate90", "rotate180", "rotate270"}
	out := make([]manifestData, 0)
	for _, mf := range *masterFiles {

		item := manifestData{ID: mf.ID, PID: mf.PID, Filename: mf.Filename,
			Title: mf.Title, Description: mf.Description, Exemplar: mf.Exemplar,
			Width: mf.ImageTechMeta.Width, Height: mf.ImageTechMeta.Height, Orientation: "normal"}
		if mf.TextSource.Valid {
			item.TextSource = mf.TextSource.Int64
		}
		// convert rails enum to string
		item.Orientation = orientations[mf.ImageTechMeta.Orientation]

		// get original info if this is a clone
		if mf.ClonedFrom > 0 {
			log.Printf("INFO: lookup original masterfile %d for clone", mf.ClonedFrom)
			var clonedFrom cloneData
			mfResp := svc.GDB.Table("master_files").Select("id", "pid", "filename").Find(&clonedFrom, mf.ClonedFrom)
			if mfResp.Error != nil {
				return nil, fmt.Errorf("master file %d is cloned from %d, but original could not be found: %s",
					mf.ID, mf.ClonedFrom, mfResp.Error.Error())
			}
			item.ClonedFrom = &clonedFrom
		}

		out = append(out, item)
	}
	log.Printf("INFO: generated manifest with %d master files", len(out))
	return &out, nil
}
