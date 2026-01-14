package main

import (
	"encoding/csv"
	"errors"
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type agency struct {
	ID   int64  `json:"id"`
	Name string `json:"name"`
}

func (svc *ServiceContext) getAgencies(c *gin.Context) {
	var out []agency
	if err := svc.GDB.Order("name asc").Find(&out).Error; err != nil {
		log.Printf("ERROR: unable to get agencies: %s", err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}
	c.JSON(http.StatusOK, out)
}

type containerType struct {
	ID         int64  `json:"id"`
	Name       string `json:"name"`
	HasFolders bool   `json:"hasFolders"`
}

func (svc *ServiceContext) getContainerTypes(c *gin.Context) {
	var out []containerType
	if err := svc.GDB.Find(&out).Error; err != nil {
		log.Printf("ERROR: unable to get container types: %s", err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}
	c.JSON(http.StatusOK, out)
}

func (svc *ServiceContext) getContainerType(c *gin.Context) {
	cid := c.Param("id")
	var ct containerType
	if err := svc.GDB.First(&ct, cid).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			log.Printf("INFO: container type %s not found", cid)
			c.String(http.StatusNotFound, fmt.Sprintf("%s not found", cid))
		} else {
			log.Printf("ERROR: unable to get container type %s: %s", cid, err.Error())
			c.String(http.StatusInternalServerError, err.Error())
		}
		return
	}
	c.String(http.StatusOK, ct.Name)
}

func (svc *ServiceContext) getComponent(c *gin.Context) {
	cid := c.Param("id")
	var cmp component
	if err := svc.GDB.Preload("ComponentType").First(&cmp, cid).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			log.Printf("INFO: component %s not found", cid)
			c.String(http.StatusNotFound, fmt.Sprintf("%s not found", cid))
		} else {
			log.Printf("ERROR: unable to get component %s: %s", cid, err.Error())
			c.String(http.StatusInternalServerError, err.Error())
		}
		return
	}
	c.JSON(http.StatusOK, cmp)
}

type customer struct {
	ID             int64  `json:"id"`
	FirstName      string `json:"firstName"`
	LastName       string `json:"lastName"`
	Email          string `json:"email"`
	AcademicStatus string `json:"academicStatus"`
}

func (svc *ServiceContext) getCustomers(c *gin.Context) {
	var out []customer
	q := "select c.*, s.name as academic_status from customers c"
	q += " inner join academic_statuses s on s.id = academic_status_id"
	q += " where last_name != '' order by last_name asc"
	if err := svc.GDB.Raw(q).Scan(&out).Error; err != nil {
		log.Printf("ERROR: unable to get container types: %s", err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}
	c.JSON(http.StatusOK, out)
}

func (svc *ServiceContext) getOCRInfo(c *gin.Context) {
	type ocrResp struct {
		OCRHints      []ocrHint         `json:"hints"`
		LanguageHints []ocrLanguageHint `json:"languages"`
	}
	out := ocrResp{}
	if err := svc.GDB.Find(&out.OCRHints).Error; err != nil {
		log.Printf("ERROR: unable to get ocr hints: %s", err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}

	out.LanguageHints = make([]ocrLanguageHint, 0)
	f, err := os.Open("./data/languages.csv")
	if err != nil {
		log.Printf("ERROR: unable to load ocr language hints: %s", err.Error())
	} else {
		defer f.Close()
		csvReader := csv.NewReader(f)
		langRecs, err := csvReader.ReadAll()
		if err != nil {
			log.Printf("ERROR: unable to parse languages file: %s", err.Error())
		} else {
			for _, rec := range langRecs {
				out.LanguageHints = append(out.LanguageHints, ocrLanguageHint{Code: rec[0], Language: rec[1]})
			}
		}
	}

	c.JSON(http.StatusOK, out)
}

func (svc *ServiceContext) getIntendedUses(c *gin.Context) {
	var out []intendedUse
	if err := svc.GDB.Where("is_approved=? AND is_internal_use_only=?", 1, 0).Find(&out).Error; err != nil {
		log.Printf("ERROR: unable to get intended uses: %s", err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}
	c.JSON(http.StatusOK, out)
}

type staffMember struct {
	ID          int64  `json:"id"`
	ComputingID string `json:"computingID"`
	FirstName   string `json:"firstName"`
	LastName    string `json:"lastName"`
	Email       string `json:"email"`
	Role        int    `json:"role"`
}

func (svc *ServiceContext) getActiveStaff(c *gin.Context) {
	var out []staffMember
	if err := svc.GDB.Where("is_active=1").Order("last_name asc").Find(&out).Error; err != nil {
		log.Printf("ERROR: unable to get staff: %s", err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}
	c.JSON(http.StatusOK, out)
}

func (svc *ServiceContext) getStaffMember(c *gin.Context) {
	cid := c.Query("cid")
	id := c.Query("id")
	if id == "" && cid == "" {
		log.Printf("INFO: invald staff lookup request; missing id and cid")
		c.String(http.StatusBadRequest, "param id or cid is required")
		return
	}

	var out staffMember
	if id != "" {
		log.Printf("INFO: lookup staff by id %s", id)
		if err := svc.GDB.First(&out, id).Error; err != nil {
			if errors.Is(err, gorm.ErrRecordNotFound) == false {
				log.Printf("ERROR: unable to get staff %s: %s", id, err.Error())
				c.String(http.StatusInternalServerError, err.Error())
			} else {
				log.Printf("INFO: staff %s not found", id)
				c.String(http.StatusNotFound, fmt.Sprintf("%s not found", id))
			}
			return
		}
	} else {
		log.Printf("INFO: lookup staff by computing id %s", cid)
		if err := svc.GDB.Where("computing_id=?", cid).First(&out).Error; err != nil {
			if errors.Is(err, gorm.ErrRecordNotFound) == false {
				log.Printf("ERROR: unable to get staff %s: %s", cid, err.Error())
				c.String(http.StatusInternalServerError, err.Error())
			} else {
				log.Printf("INFO: staff %s not found", cid)
				c.String(http.StatusNotFound, fmt.Sprintf("%s not found", cid))
			}
			return
		}
	}
	c.JSON(http.StatusOK, out)
}

type unitInfo struct {
	ID                  int64  `json:"id"`
	MetadataPID         string `json:"metadataPID"`
	CallNumber          string `json:"callNumber"`
	CatalogKey          string `json:"catalogKey"`
	SpecialInstructions string `json:"specialInstructions"`
	StaffNotes          string `json:"staffNotes"`
	IntendedUse         string `json:"intendedUse"`
}

func (svc *ServiceContext) getUnitInfo(c *gin.Context) {
	uid := c.Param("id")
	var tgtUnit unit
	if err := svc.GDB.Preload("Metadata").Preload("IntendedUse").Where("id=?", uid).First(&tgtUnit).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) == false {
			log.Printf("ERROR: unable to get unit %s: %s", uid, err.Error())
			c.String(http.StatusInternalServerError, err.Error())
		} else {
			log.Printf("INFO: unit %s not found", uid)
			c.String(http.StatusNotFound, fmt.Sprintf("%s not found", uid))
		}
		return
	}
	out := unitInfo{
		ID:                  tgtUnit.ID,
		MetadataPID:         tgtUnit.Metadata.PID,
		CallNumber:          tgtUnit.Metadata.CallNumber,
		CatalogKey:          tgtUnit.Metadata.CatalogKey,
		IntendedUse:         tgtUnit.IntendedUse.Description,
		StaffNotes:          tgtUnit.StaffNotes,
		SpecialInstructions: tgtUnit.SpecialInstructions,
	}

	c.JSON(http.StatusOK, out)
}
