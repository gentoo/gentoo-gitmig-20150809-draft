#!/bin/bash

VERSION="0.0"

if [ -z $1 ]; then
	DATE=`date +%Y%m%d`	# Current date
	#DATE="20030717"	# Static date
else
	DATE=$1
fi

CVS=`which cvs`
TAR=`which tar`

CVS_OPTIONS="-z3"
CVS_REPOSITORY="-d:pserver:anonymous@cvs.prelude-ids.org:/cvsroot/prelude"


$CVS ${CVS_OPTIONS} ${CVS_REPOSITORY} login
$CVS ${CVS_OPTIONS} ${CVS_REPOSITORY} checkout -D $DATE piwi

mv piwi piwi-$VERSION.$DATE
tar cvjf piwi-$VERSION.$DATE.tar.bz2 piwi-$VERSION.$DATE --exclude CVS
rm -rf piwi-$VERSION.$DATE
