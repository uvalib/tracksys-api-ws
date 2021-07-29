package main

import (
	"database/sql"
	"log"
	"net/http"
	"regexp"

	"github.com/gin-gonic/gin"
	dbx "github.com/go-ozzo/ozzo-dbx"
)

type circulationData struct {
	DateRequested string `db:"date_request_submitted" json:"request_date"`
	Status        string `db:"order_status" json:"status"`
	Email         string `db:"email" json:"email"`
	LastName      string `db:"last_name" json:"last_name"`
	FirstName     string `db:"first_name" json:"first_name"`
	CallNumber    string `db:"call_number" json:"call_number"`
}

func (svc *ServiceContext) getCirculationData(c *gin.Context) {
	out := make([]circulationData, 0)
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

	qSQL := `select date_request_submitted,order_status,c.email, last_name, first_name, m.call_number  from orders o
			inner join customers c on c.id = customer_id
			inner join units u on u.order_id = o.id
			inner join metadata m on m.id = u.metadata_id
		where date_request_submitted >= {:fromdate} and date_request_submitted <= {:todate}
			and c.email is not null and m.type="SirsiMetadata" and m.call_number <> ''
			and (order_status='completed' || order_status='approved' || order_status='await_fee')`
	q := svc.DB.NewQuery(qSQL)
	q.Bind(dbx.Params{"fromdate": fromDate, "todate": toDate})
	err := q.All(&out)
	if err != nil {
		if err != sql.ErrNoRows {
			log.Printf("ERROR: unable to get circulation report: %s", err.Error())
			c.String(http.StatusInternalServerError, err.Error())
		} else {
			log.Printf("WARNING: unable to get circulation report")
			c.String(http.StatusNotFound, "unable to get circulation report")
		}
		return
	}
	c.JSON(http.StatusOK, out)
}
