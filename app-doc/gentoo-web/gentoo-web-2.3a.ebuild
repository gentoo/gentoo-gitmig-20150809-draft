# Copyright 1999-2001 Gentoo Technologies, Inc. Distributed under the terms
# of the GNU General Public License, v2 or later 
# $Header: /var/cvsroot/gentoo-x86/app-doc/gentoo-web/gentoo-web-2.3a.ebuild,v 1.9 2002/07/19 17:51:07 g2boojum Exp $
 
S=${WORKDIR}/gentoo-src/gentoo-web
TEMPLATE=${S}/xsl/guide-main.xsl
DESCRIPTION="www.gentoo.org website"
SRC_URI="http://www.red-bean.com/cvs2cl/cvs2cl.pl"
HOMEPAGE="http://www.gentoo.org"
RDEPEND="virtual/python dev-libs/libxslt"

src_unpack() {
	local myhost
	myhost=`hostname`
	if [ "$myhost" = "laptop.kicks-ass.net" ]
	then
		echo -e "\e[32;1mMEEKROB detected.\e[0m"
		GENTOO_SRCDIR=/home/meekrob/gentoo-src
		WEBROOT=/home/httpd/htdocs
	elif [ "$myhost" = "inventor.gentoo.org" ]
	then
		echo -e "\e[32;1mDROBBINS detected.\e[0m"
		GENTOO_SRCDIR=/home/drobbins/gentoo-src
		WEBROOT=/home/httpd/htdocs
	elif [ "$myhost" = "chiba.3jane.net" ]
	then
		echo -e "\e[32;1mCHIBA detected.\e[0m"
		WEBROOT=/www/virtual/www.gentoo.org/htdocs
	else
		if [ -n "${WEBROOT}" ]
		then
			# assign it from the environment.
			WEBROOT=${WEBROOT}
		else
			# give it a nice default
			WEBROOT=/home/httpd/htdocs
		fi
	fi

	echo "Setting GENTOO_SRCDIR to $GENTOO_SRCDIR"
	echo "Setting WEBROOT to $WEBROOT"
	echo "${WEBROOT}" > ${T}/webroot		

	cd ${WORKDIR}/${P}
	if [ -n "$GENTOO_SRCDIR" ]
	then
		ln -s "${GENTOO_SRCDIR}" gentoo-src || die
	else
		echo "GENTOO_SRCDIR $GENTOO_SRCDIR"
		cvs -d /home/cvsroot co gentoo-src
	fi
}	

src_compile() {
	cd ${S}
	python python/gendevlistxml.py txt/devlist.txt xml/main-devlist.xml || die
}

src_install() {
	export WEBROOT="`cat ${T}/webroot`"
	dodir ${WEBROOT}/doc
	dodir ${WEBROOT}/projects
	insinto ${WEBROOT}/doc
	
	local x
	local y
	for y in en es fr
	do
		cd ${S}/xml/doc/${y}
		for x in *.xml
		do
			x=`basename ${x} .xml`
			xsltproc $TEMPLATE ${x}.xml > ${D}${WEBROOT}/doc/${x}.html || die
		done
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
	
	cd ${S}
	doins css/main-new.css css/resume.css
	
	#dynamic firewalls tools page
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
	
	#This can only be done in ${T} since ${S} may be a live CVS tree
	cd ${T}
	mkdir -p xml/packages
	dodir ${WEBROOT}/packages/
	insinto ${WEBROOT}/packages/
	#we're getting bonkers stuff in the main packages pages, so lets make sure it's empty
	python ${S}/python/genpkgxml.py ${T}/main-packages-old-style.xml || die
	python ${S}/python/genpkgxml-v2.py ${T}/main-packages.xml || die
	for DIR in `ls xml/packages`
	do
		dodir ${WEBROOT}/packages/${DIR}
		for FILE in  `ls xml/packages/${DIR}`
		do
			FILE=${FILE%.xml}
			echo -n "."	
			xsltproc $TEMPLATE xml/packages/${DIR}/${FILE}.xml > ${D}/${WEBROOT}/packages/${DIR}/${FILE}.html || die
		done
	done

	ROOT=${OLDROOT}
	
	xsltproc $TEMPLATE ${T}/main-packages.xml > ${D}${WEBROOT}/index-packages.html || die
	xsltproc $TEMPLATE ${T}/main-packages-old-style.xml > ${D}${WEBROOT}/index-packages-old.html || die
	xsltproc $TEMPLATE ${S}/xml/main-devlist.xml > ${D}${WEBROOT}/index-devlist.html || die
	
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
	export WEBROOT="`cat ${T}/webroot`"
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
