#!/bin/sh

TMPFILE="/tmp/orbref"
if([ -e ${TMPFILE} ]) then
	echo "${TMPFILE} already exists. Delete it please."
	exit
fi

pushd /opt/fresco &> /dev/null

echo "Starting up the server..."
bin/server -R ior &> ${TMPFILE} &
sleep 2

REF=`head -n 1 ${TMPFILE} | cut -d " " -f 3`
rm ${TMPFILE}

echo "Starting the demo..."
bin/demo -ORBInitRef ${REF}

popd &> /dev/null
