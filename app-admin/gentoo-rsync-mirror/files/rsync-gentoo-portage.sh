#!/bin/bash

RSYNC="/usr/bin/rsync"
OPTS="--quiet --recursive --links --perms --times --devices --compress --delete --timeout=600"
#Uncomment the following line only if you have been granted access to rsync1.us.gentoo.org
#SRC="rsync://rsync1.us.gentoo.org/gentoo-portage"
#If you are waiting for access to our master mirror, select one of our mirrors to mirror from:
SRC="rsync://rsync.gentoo.org/gentoo-portage"
DST="/opt/gentoo-rsync/portage/"

echo "Started update at" `date` >> /var/log/$0.log 2>&1
logger -t rsync "re-rsyncing the gentoo-portage tree"
${RSYNC} ${OPTS} ${SRC} ${DST} >> /var/log/$0.log 2>&1

echo "End: "`date` >> /var/log/$0.log 2>&1 

