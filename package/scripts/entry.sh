#!/usr/bin/env bash
#
# run application
#

# run the server
cd bin; ./tracksys-api-ws -saxon $SAXON_SERVICE_URL -pdf $PDF_SERVICE_URL -iiifman $IIIF_MANIFEST_SERVICE_URL -iiif $IIIF_SERVICE_URL  -dbhost $DBHOST -dbport $DBPORT -dbname $DBNAME -dbuser $DBUSER -dbpass $DBPASS

# return the status
exit $?

#
# end of file
#