package main

import (
	"fmt"
	"time"
)

func (svc *ServiceContext) startCache() {
	svc.Cache.Data = make(map[string]CacheRecord)
	ticker := time.NewTicker(30 * time.Second)
	for range ticker.C {
		ts := time.Now()
		svc.Cache.Mux.Lock()
		for key, val := range svc.Cache.Data {
			if ts.After(val.ExpiresAt) {
				delete(svc.Cache.Data, key)
			}
		}
		svc.Cache.Mux.Unlock()
	}
}

func (svc *ServiceContext) getCache(dataType string, pid string) []byte {
	key := fmt.Sprintf("%s-%s", pid, dataType)
	svc.Cache.Mux.Lock()
	defer svc.Cache.Mux.Unlock()
	cacheRec, ok := svc.Cache.Data[key]
	if ok {
		return cacheRec.Data
	}
	return nil
}

func (svc *ServiceContext) updateCache(dataType string, pid string, data []byte) {
	key := fmt.Sprintf("%s-%s", pid, dataType)
	svc.Cache.Mux.Lock()
	svc.Cache.Data[key] = CacheRecord{Data: data, ExpiresAt: time.Now().Add(5 * time.Minute)}
	svc.Cache.Mux.Unlock()
}
