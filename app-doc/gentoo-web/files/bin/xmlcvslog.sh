#!/bin/bash
HOMEDIR=/home/drobbins
CVSDIR=${HOMEDIR}/gentoo/gentoo-x86
OUTLOG=${HOMEDIR}/gentoo/xmlcvslog.txt
WEBDIR=/usr/local/httpd/htdocs
XSLTP=/opt/gnome/bin/xsltproc

cd $CVSDIR 
cvs -q update -dP
yesterday=`date -d "1 day ago 00:00" -R`
today=`date -d "00:00" -R`
cvsdate=-d\'${yesterday}\<${today}\'
nicedate=`date -d yesterday +"%d %b %Y %Z (%z)"`
/usr/bin/cvs2cl.pl --xml -f $OUTLOG -l "${cvsdate}" 
$XSLTP ${WEBDIR}/xsl/cvs.xsl $OUTLOG | $XSLTP ${WEBDIR}/xsl/guide-main.xsl > ${WEBDIR}/index-changelog.html
chmod 0644 ${WEBDIR}/index-changelog.html
