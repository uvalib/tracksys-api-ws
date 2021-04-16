# Tracksys API Web Service

This is a web service that comminucates directly with the TrackSys Database
to expose a variety of useful API endpoints for metadata.

Requires Go 1.16.0+

### Current API

* GET /version - get version information
* GET /manifest/:pid - get a list of published master files for a metadata record
* GET /published/dpla - get a list of IDs that have been published to DPLA
* GET /published/virgo - get a list of catalog keys that have been published to Virgo
* GET /enriched/other/:pid - get enriched metadata for non-sirsi metadata published to Virgo
* GET /enriched/sirsi/:key - get enriched metadata for sirsi metadata published to Virgo
* GET /stylesheet/:id - get a stylesheet (supports the metadata API)
* GET /pid/:pid - get a summary for any type of PID
* GET /pid/:pid/access - get access rights for a PID (uva, public or private)
* GET /pid/:pid/type - get the type of data represented by this PID
* GET /pid/:pid/text - get OCR text from the PID
* GET /metadata/:pid - get a full metadata record for a PID
* GET /search - find a matching PID; requires param ?q=what_to_look_for
