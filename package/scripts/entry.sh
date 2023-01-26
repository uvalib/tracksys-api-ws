#!/usr/bin/env bash
#
# run application
#

# run the server
cd bin; ./tracksys-api-ws                 \
   -api        $TRACKSYS_API_URL          \
   -saxon      $SAXON_SERVICE_URL         \
   -pdf        $PDF_SERVICE_URL           \
   -iiifman    $IIIF_MANIFEST_SERVICE_URL \
   -iiif       $IIIF_SERVICE_URL          \
   -tracksys   $TRACKSYS_URL              \
   -dbhost     $DBHOST                    \
   -dbport     $DBPORT                    \
   -dbname     $DBNAME                    \
   -dbuser     $DBUSER                    \
   -dbpass     $DBPASS                    \
   -key        $WRITE_KEY

# return the status
exit $?

#
# end of file
#
