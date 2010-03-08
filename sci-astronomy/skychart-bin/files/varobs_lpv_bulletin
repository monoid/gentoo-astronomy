#!/bin/sh
if [ "${LD_LIBRARY_PATH+set}" = "set" ] ; then
   export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/opt/skychart/lib"
else
   export LD_LIBRARY_PATH="/opt/skychart/lib"
fi
exec /opt/skychart/bin/varobs_lpv_bulletin "$@"
