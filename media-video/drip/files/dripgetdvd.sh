#!/bin/sh

if test -z "$1"
then
	exit 1
fi

DVD="`grep $1 /etc/fstab | awk '{print $1}'`"

while test -L "${DVD}"
do
	NEWDVD="`readlink ${DVD}`"
	if test -z "`echo ${NEWDVD} |grep -e "^/dev"`"
	then
		DVD="${DVD%/*}/${NEWDVD}"
	fi
done

echo ${DVD}

