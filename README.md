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
* POST /pid/:pid/ocr - add OCR text to a masterfile PID. Required form fields are text and key. See below for a similar command example.
* GET /metadata/:pid - get a full metadata record for a PID
* GET /search - find a matching PID; requires param ?q=what_to_look_for
* GET /transform/:uuid - get the status log of an in-process transformation
* POST /transform - transform XmlMetadata using the supplied XSL from multipart form data. Supported modes: test, single and global. Example command:
```
curl -X POST http://api-host/api/transform \
     -H "Content-Type: multipart/form-data" \
     -F user=computeID -F key=accessKey \
     -F mode=test -F pid=uva-lib:729248 \
     -F xsl=@/path/to/test.xsl -F "comment=transform notes"
```

