#!/bin/bash

BASE_VERSION="0.8.0"

if [ -z $1 ]; then
	DATE=`date +%Y%m%d`	# Current date
	#DATE="20030717"	# Static date
else
	DATE=$1
fi

VERSION="v$BASE_VERSION.$DATE"

CVS=`which cvs`
TAR=`which tar`

CVS_OPTIONS="-z3"
CVS_REPOSITORY="-d:pserver:anonymous@cvs.prelude-ids.org:/cvsroot/prelude"


$CVS ${CVS_OPTIONS} ${CVS_REPOSITORY} login
$CVS ${CVS_OPTIONS} ${CVS_REPOSITORY} checkout -D $DATE piwi

cd piwi
tar cvzf ../piwi_$VERSION.tar.gz . --exclude CVS
cd ..
mv piwi_$VERSION.tar.gz /usr/portage/distfiles/
rm -rf piwi
