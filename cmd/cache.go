package main

import (
	"fmt"
	"time"
)

func (svc *ServiceContext) startCache() {
	svc.Cache = make(map[string]CacheRecord)
	ticker := time.NewTicker(30 * time.Second)
	for range ticker.C {
		ts := time.Now()
		for key, val := range svc.Cache {
			if ts.After(val.ExpiresAt) {
				delete(svc.Cache, key)
			}
		}
	}
}

func (svc *ServiceContext) getCache(dataType string, pid string) []byte {
	key := fmt.Sprintf("%s-%s", pid, dataType)
	cacheRec, ok := svc.Cache[key]
	if ok {
		return cacheRec.Data
	}
	return nil
}

func (svc *ServiceContext) updateCache(dataType string, pid string, data []byte) {
	key := fmt.Sprintf("%s-%s", pid, dataType)
	svc.Cache[key] = CacheRecord{Data: data, ExpiresAt: time.Now().Add(5 * time.Minute)}
}

func (svc *ServiceContext) clearCache(key string, data []byte) {
	svc.Cache = make(map[string]CacheRecord)
}
