#!/bin/bash
USER=drobbins
HOMEDIR=/home/d/${USER}
CVSDIR=${HOMEDIR}/scripts/gentoo-x86
OUTLOG=${HOMEDIR}/scripts/cvslog.out
OUTMAIL=${HOMEDIR}/scripts/cvsmail.out
WEBDIR=/www/virtual/www.gentoo.org/htdocs
XSLTP=/usr/bin/xsltproc
TMPFILE=${HOMEDIR}/scripts/cvslog.tmp

if [ -z "$CVSMAIL" ]
then
	export CVSMAIL="yes"
fi

cd $CVSDIR 
cvs -q update -dP
yesterday=`date -d "1 day ago 00:00" -R`
today=`date -d "00:00" -R`
cvsdate=-d\'${yesterday}\<${today}\'
nicedate=`date -d yesterday +"%d %b %Y %Z (%z)"`
/usr/bin/cvs2cl.pl --xml -f $OUTLOG -l "${cvsdate}" 
/usr/bin/sed -e 's/xmlns=".*"//' $OUTLOG > ${OUTLOG}.2
$XSLTP ${WEBDIR}/xsl/cvs.xsl ${OUTLOG}.2 > $TMPFILE
$XSLTP ${WEBDIR}/xsl/guide-main.xsl $TMPFILE > ${WEBDIR}/index-changelog.html
chmod 0644 ${WEBDIR}/index-changelog.html
if [ "$CVSMAIL" = "yes" ]
then
	/usr/bin/cvs2cl.pl -f ${OUTMAIL} -l "${cvsdate}" 
	mutt -x gentoo-cvs -s "cvs log for $nicedate" < ${OUTMAIL} 
fi
