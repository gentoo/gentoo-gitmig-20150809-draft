# Copyright 1999-2001 Gentoo Technologies, Inc. Distributed under the terms
# of the GNU General Public License, v2 or later 
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/gentoo-web/gentoo-web-2.2.ebuild,v 1.30 2002/01/08 19:39:03 drobbins Exp $
 
# WARNING: THIS EBUILD SHOULD BE EDITED BY DANIEL ROBBINS ONLY
 
TEMPLATE="xsl/guide-main.xsl"
S=${WORKDIR}/gentoo-src/gentoo-web
DESCRIPTION="www.gentoo.org website"
SRC_URI="http://www.red-bean.com/cvs2cl/cvs2cl.pl"
HOMEPAGE="http://www.gentoo.org"
RDEPEND="virtual/python dev-libs/libxslt"
WEBROOT=/www/virtual/www.gentoo.org/htdocs

src_unpack() {
	if [ "$MAINTAINER" != "yes" ]
	then
		echo "This will zap stuff in ${WEBROOT}."
		echo "Beware -- maintainers only."
	fi
	cd ${WORKDIR}/${P}
	cvs -d /home/cvsroot co gentoo-src
}

src_install() {
	dodir ${WEBROOT}/doc
	dodir ${WEBROOT}/projects
	insinto ${WEBROOT}/doc
	cd ${S}
	local x
	for x in build desktop xml-guide portage-user gentoo-howto faq nvidia_tsg openafs cvs-tutorial shots ebuild-submit
	do
		xsltproc $TEMPLATE xml/${x}.xml > ${D}${WEBROOT}/doc/${x}.html || die
	done
	dodir ${WEBROOT}/images
	insinto ${WEBROOT}/images
	cd ${S}/images
	doins paypal.png gtop-s.jpg znurt.jpg gbot-s.gif gridtest.gif gentoo-new.gif install*.gif fishhead.gif line.gif icon-* keychain-2.gif gentoo-2.gif
	insinto ${WEBROOT}/images/shots
	doins shots/*
	local x
	for x in shots/desktop*.png
	do
		[ "${x%*small.png}" != "${x}" ] && continue
		sed -e "s:TITLE:${x}:" -e "s:IMG:/images/${x}:" ${S}/html/shell.html > ${D}${WEBROOT}/images/${x%.png}.html
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
	
	insinto ${WEBROOT}

	xsltproc $TEMPLATE xml/main-news.xml > ${D}${WEBROOT}/index.html || die
	xsltproc $TEMPLATE xml/main-about.xml > ${D}${WEBROOT}/index-about.html || die
	xsltproc $TEMPLATE xml/main-download.xml > ${D}${WEBROOT}/index-download.html || die
	xsltproc $TEMPLATE xml/main-projects.xml > ${D}${WEBROOT}/index-projects.html || die
	xsltproc $TEMPLATE xml/main-docs.xml > ${D}${WEBROOT}/index-docs.html || die

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

	#wikistuffs
#	dodir ${WEBROOT}/wiki/images
#	dodir ${WEBROOT}/wiki/bios
#	insinto ${WEBROOT}/wiki
#	cd ${S}/wiki
#	doins *.php
#	cd images
#	insinto ${WEBROOT}/wiki/images
#	doins *.gif
#	cd ../bios
#	insinto ${WEBROOT}/wiki/bios
#	doins *.png *.jpg *.gif
	
#	cd ${D}
#	chmod -R g+rw,o+r *
#	chown -R root.root *
#	cd ${D}/usr/local/httpd
#	chown -R drobbins.webadmin htdocs 
#	chmod -R g+rws htdocs

	dobin ${DISTDIR}/cvs2cl.pl
	dosbin ${S}/bin/cvslog.sh
#	dosbin ${FILESDIR}/bin/wiki.pl
#	chmod o-rwx,g+rx ${D}/usr/sbin/wiki.pl
#	chown root.dbadmin ${D}/usr/sbin/wiki.pl

#	ln -s /home/mailman/icons ${D}${WEBROOT}/mailman-images
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
}

#pkg_postinst() {
#	source /home/drobbins/.wiki-auth
#	cd ${WEBROOT}/wiki
#	cp functions.php functions.php.orig
#	sed -e "s:##USER##:${WIKI_USER}:g" -e "s:##PASS##:${WIKI_PASS}:g" -e "s:##DB##:${WIKI_DB}:g" functions.php.orig > functions.php
#	rm functions.php.orig
#	cd /usr/sbin
#	cp wiki.pl wiki.pl.orig
#	sed -e "s:##USER##:${WIKI_USER}:g" -e "s:##PASS##:${WIKI_PASS}:g" -e "s:##DB##:${WIKI_DB}:g" wiki.pl.orig > wiki.pl
#	rm wiki.pl.orig
#}


