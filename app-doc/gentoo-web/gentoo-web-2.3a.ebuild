# Copyright 1999-2001 Gentoo Technologies, Inc. Distributed under the terms
# of the GNU General Public License, v2 or later 
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/gentoo-web/gentoo-web-2.3a.ebuild,v 1.3 2002/07/03 15:52:28 drobbins Exp $
 
 
S=${WORKDIR}/gentoo-src/gentoo-web
TEMPLATE=${S}/xsl/guide-main.xsl
DESCRIPTION="www.gentoo.org website"
SRC_URI="http://www.red-bean.com/cvs2cl/cvs2cl.pl"
HOMEPAGE="http://www.gentoo.org"
RDEPEND="virtual/python dev-libs/libxslt"
WEBROOT=/www/virtual/www.gentoo.org/htdocs

src_unpack() {
	local myhost
	myhost=`hostname`
	if [ "$myhost" = "laptop.kicks-ass.net" ]
	then
		export GENTOO_SRCDIR=/home/meekrob/gentoo-src
		WEBROOT=/home/httpd/htdocs
		echo -e "\e[32;1mMEEKROB detected.\e[0m"
		echo "Setting GENTOO_SRCDIR to $GENTOO_SRCDIR"
		echo "Setting WEBROOT to $WEBROOT"
	fi
	if [ "$MAINTAINER" != "yes" ]
	then
		echo "This will zap stuff in ${WEBROOT}."
		echo "Beware -- maintainers only."
	fi
	cd ${WORKDIR}/${P}
	if [ "$myhost" = "inventor.gentoo.org" ]
	then
		echo -e "\e[32;1mCHIBA detected.\e[0m"
		ln -s /home/drobbins/gentoo-src gentoo-src
	elif [ "$myhost" = "chiba.3jane.net" ]
	then
		cvs -d /home/cvsroot co gentoo-src
	elif [ -n "$GENTOO_SRCDIR" ]
	then
		ln -s ${GENTOO_SRCDIR} gentoo-src || die
	else
		die "Please set the GENTOO_SRCDIR env var to point to the gentoo-src tree"
	fi
}

src_compile() {
	python ${S}/python/gendevlistxml.py txt/devlist.txt xml/main-devlist.xml || die
}

src_install() {
	dodir ${WEBROOT}/doc
	dodir ${WEBROOT}/projects
	insinto ${WEBROOT}/doc
	
	#process english docs
	cd ${S}/xml/doc/en
	local x
	for x in *.xml
	do
		x=`basename ${x} .xml`
		xsltproc $TEMPLATE ${x}.xml > ${D}${WEBROOT}/doc/${x}.html || die
	done
	cd ${S}
	
	#process spanish docs
	cd ${S}/xml/doc/es
	local x
	for x in *.xml
	do
		x=`basename ${x} .xml`
		xsltproc $TEMPLATE ${x}.xml > ${D}${WEBROOT}/doc/${x}.html || die
	done
	cd ${S}
	
	#process french docs
	cd ${S}/xml/doc/fr
	local x
	for x in *.xml
	do
		x=`basename ${x} .xml`
		xsltproc $TEMPLATE ${x}.xml > ${D}${WEBROOT}/doc/${x}.html || die
	done
	cd ${S}
	
	cp txt/firewall ${D}${WEBROOT}/doc/
	dodir ${WEBROOT}/images
	insinto ${WEBROOT}/images
	cp -a ${S}/images ${D}/${WEBROOT}
	local x
	cd images
	for x in shots/desktop*.png
	do
		[ "${x%*small.png}" != "${x}" ] && continue
		sed -e "s:TITLE:${x}:" -e "s:IMG:http\://www.ibiblio.org/gentoo/images/${x}:" ${S}/html/shell.html > ${D}${WEBROOT}/images/${x%.png}.html
	done
	
	insinto ${WEBROOT}
	doins favicon.ico
	
	#dynamic firewalls tools page
	cd ${S}
	xsltproc $TEMPLATE xml/dynfw.xml > ${D}${WEBROOT}/projects/dynfw.html	|| die
	xsltproc $TEMPLATE xml/project-xml.xml > ${D}${WEBROOT}/projects/xml.html	|| die
	
	#resume
	xsltproc xsl/resume-html.xsl xml/resume.xml > ${D}${WEBROOT}/resume.html || die
	
	#both URLs should work
	dodir ${WEBROOT}/projects/keychain
	xsltproc $TEMPLATE xml/keychain.xml > ${D}${WEBROOT}/projects/keychain.html || die	
	xsltproc $TEMPLATE xml/keychain.xml > ${D}${WEBROOT}/projects/keychain/index.html	|| die
	
	insinto ${WEBROOT}/projects
	doins dynfw/dynfw-1.0.1.tar.gz 
	
	cd ..
	tar czvf ${D}${WEBROOT}/projects/guide-xml-latest.tar.gz gentoo-web 
	cd ${S}
	dodir ${WEBROOT}/news	
	local mydate
	mydate=`date +"%d %b %Y"`
	echo "<?xml version='1.0'?>" > ${T}/main-news.xml
	echo '<mainpage id="news"><title>Gentoo Linux News</title><author title="Author"><mail link="drobbins@gentoo.org">Daniel Robbins</mail></author>' >> ${T}/main-news.xml
	echo "<version>1.0</version><date>${mydate}</date><newsitems>" >> ${T}/main-news.xml
	local myext
	for x in `find xml/news -iname 200*.xml | sort -r`
	do
		myext=`basename $x`
		myext=${myext%*.xml}
		cat $x | sed -e "1d" -e "s:<news:<news external=\"/news/${myext}.html\":" >> ${T}/main-news.xml
		xsltproc xsl/guide-main.xsl $x > ${D}/${WEBROOT}/news/${myext}.html
	done
	echo "</newsitems></mainpage>" >> ${T}/main-news.xml
	insinto ${WEBROOT}
	xsltproc $TEMPLATE ${T}/main-news.xml > ${D}${WEBROOT}/index.html || die
	xsltproc $TEMPLATE xml/main-about.xml > ${D}${WEBROOT}/index-about.html || die
	xsltproc $TEMPLATE xml/main-download.xml > ${D}${WEBROOT}/index-download.html || die
	xsltproc $TEMPLATE xml/main-projects.xml > ${D}${WEBROOT}/index-projects.html || die
	xsltproc $TEMPLATE xml/main-docs.xml > ${D}${WEBROOT}/index-docs.html || die
	xsltproc $TEMPLATE xml/main-articles.xml > ${D}${WEBROOT}/index-articles.html || die
	xsltproc $TEMPLATE xml/main-contract.xml > ${D}${WEBROOT}/index-contract.html || die
	xsltproc $TEMPLATE xml/main-graphics.xml > ${D}${WEBROOT}/index-graphics.html || die
	OLDROOT=${ROOT} ; unset ROOT
	
	mkdir -p xml/packages
	dodir ${WEBROOT}/packages/
	insinto ${WEBROOT}/packages/
	#we're getting bonkers stuff in the main packages pages, so lets make sure it's empty
	rm ${T}/main-packages.xml
	python python/genpkgxml.py ${T}/main-packages-old-style.xml || die
	python python/genpkgxml-v2.py ${T}/main-packages.xml || die
	for DIR in `ls xml/packages`
	do
		echo "Making dir: (${DIR}) ${D}/${WEBROOT}/${DIR}/"
					   	 dodir ${WEBROOT}/packages/${DIR}
		for FILE in  `ls xml/packages/${DIR} | sed 's/.xml//'`
		do
			echo ${FILE}
			echo "xsltproc $TEMPLATE xml/packages/${DIR}/${FILE}.xml > ${D}/${WEBROOT}/packages/${DIR}/${FILE}.html"
				  xsltproc $TEMPLATE xml/packages/${DIR}/${FILE}.xml > ${D}/${WEBROOT}/packages/${DIR}/${FILE}.html
		done
	done

	ROOT=${OLDROOT}
	xsltproc $TEMPLATE ${T}/main-packages.xml > ${D}${WEBROOT}/index-packages.html || die
	xsltproc $TEMPLATE ${T}/main-packages-old-style.xml > ${D}${WEBROOT}/index-packages-old.html || die
	xsltproc $TEMPLATE xml/main-devlist.xml > ${D}${WEBROOT}/index-devlist.html || die
	doins css/main-new.css css/resume.css
	
	#install XSL for later use
	dodir ${WEBROOT}/xsl
	insinto ${WEBROOT}/xsl
	cd ${S}/xsl
	doins cvs.xsl guide-main.xsl

	#install snddevices script
	dodir ${WEBROOT}/scripts
	insinto ${WEBROOT}/scripts
	cd ${S}/scripts
	doins snddevices

	dobin ${DISTDIR}/cvs2cl.pl
	dosbin ${S}/bin/cvslog.sh

	insinto ${WEBROOT}
	doins ${S}/txt/robots.txt

	cd ${D}
	chmod -R +r *

	insinto ${WEBROOT}/snapshots
	newins ${S}/html/index.html-snapshots index.html
}

pkg_preinst() {
	if [ -d ${WEBROOT}.bak ]
	then
		rm -rf ${WEBROOT}.bak
	fi
	if [ -d ${WEBROOT} ]
	then
		cp -ax ${WEBROOT} ${WEBROOT}.bak
	fi
	if [ "`hostname`" = "chiba.3jane.net" ]
	then
		echo '>>> Syncing up images to ibiblio...'
		source ~drobbins/.ssh-agent-chiba.3jane.net
		rsync --delete -ave ssh ${D}/${WEBROOT}/images/ drobbins@login.ibiblio.org:gentoo/images/
	fi
}
