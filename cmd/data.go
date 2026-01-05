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

type intendedUse struct {
	ID                    int64  `json:"id"`
	Description           string `json:"description"`
	DeliverableFormat     string `json:"deliverableFormat"`
	DeliverableResolution string `json:"deliverableResolution"`
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
	cid := c.Param("cid")
	var out staffMember
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
	c.JSON(http.StatusOK, out)
}
