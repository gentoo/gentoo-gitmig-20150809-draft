#!/bin/bash
USER=drobbins
HOMEDIR=/home/${USER}
SSHAGENTFILE=${HOMEDIR}/.ssh-agent
CVSDIR=${HOMEDIR}/gentoo/gentoo-x86
OUTLOG=${HOMEDIR}/gentoo/xmlcvslog.txt
OUTMAIL=${HOMEDIR}/gentoo/cvslog.txt
WEBDIR=/usr/local/httpd/htdocs
XSLTP=/opt/gnome/bin/xsltproc
TMPFILE=${HOMEDIR}/gentoo/xmlcvslog.tmp

source ${SSHAGENTFILE}

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
scp -o Protocol=1 ${WEBDIR}/index-changelog.html drobbins@ftp.spinn.net:www/
if [ "$CVSMAIL" = "yes" ]
then
	/usr/bin/cvs2cl.pl -f ${OUTMAIL} -l "${cvsdate}" 
	mutt -x gentoo-cvs -s "cvs log for $nicedate" < ${OUTMAIL} 
fi
