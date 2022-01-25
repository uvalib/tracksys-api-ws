package main

import (
	"errors"
	"log"
	"net/http"
	"regexp"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type circulationData struct {
	DateRequestSubmitted string `json:"request_date"`
	OrderStatus          string `json:"status"`
	Email                string `json:"email"`
	LastName             string `json:"last_name"`
	FirstName            string `json:"first_name,omitempty"`
	CallNumber           string `json:"call_number"`
}

func (svc *ServiceContext) getCirculationData(c *gin.Context) {
	fromDate := c.Query("from")
	toDate := c.Query("to")
	if fromDate == "" || toDate == "" {
		log.Printf("INFO: Invalid request is missing to or from dates")
		c.String(http.StatusBadRequest, "to and from params are required")
		return
	}
	matched, _ := regexp.MatchString(`\d{4}-\d{2}-\d{2}`, fromDate)
	if !matched {
		log.Printf("INFO: Invalid from date %s", fromDate)
		c.String(http.StatusBadRequest, "from date must match yyyy-mm-dd")
		return
	}
	matched, _ = regexp.MatchString(`\d{4}-\d{2}-\d{2}`, toDate)
	if !matched {
		log.Printf("INFO: Invalid to date %s", toDate)
		c.String(http.StatusBadRequest, "to date must match yyyy-mm-dd")
		return
	}

	out := make([]circulationData, 0)
	qSQL := `select date_request_submitted, order_status, c.email as email, last_name, first_name, call_number
		from orders o
			inner join customers c on c.id = customer_id
			inner join units u on u.order_id = o.id
			inner join metadata m on m.id = u.metadata_id
		where date_request_submitted >= ? and date_request_submitted <= ?
			and c.email is not null and m.type="SirsiMetadata" and m.call_number <> ''
			and (order_status='completed' || order_status='approved' || order_status='await_fee')`
	dbResp := svc.GDB.Raw(qSQL, fromDate, toDate).Scan(&out)
	if dbResp.Error != nil {
		if errors.Is(dbResp.Error, gorm.ErrRecordNotFound) == false {
			log.Printf("ERROR: unable to get circulation report: %s", dbResp.Error.Error())
			c.String(http.StatusInternalServerError, dbResp.Error.Error())
		} else {
			log.Printf("WARNING: unable to get circulation report")
			c.String(http.StatusNotFound, "unable to get circulation report")
		}
		return
	}

	c.JSON(http.StatusOK, out)
}
