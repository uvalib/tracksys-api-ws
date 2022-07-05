package main

import (
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
)

func (svc *ServiceContext) getApTrustReport(c *gin.Context) {
	log.Printf("INFO: get APTrust items report")
	var hits []apTrustStatus
	q := `select a.id as id ,m.pid as metadata_pid, etag,object_id,finished_at from ap_trust_statuses a
		inner join metadata m on m.id = metadata_id
		where status=?`
	err := svc.GDB.Raw(q, "Success").Order("finished_at desc").Scan(&hits).Error
	if err != nil {
		log.Printf("ERROR: unable to get aptrust report: %s", err.Error())
		c.String(http.StatusInternalServerError, err.Error())
		return
	}

	type apResp struct {
		Count int              `json:"count"`
		Data  *[]apTrustStatus `json:"data"`
	}
	out := apResp{Count: len(hits), Data: &hits}

	c.JSON(http.StatusOK, out)
}
