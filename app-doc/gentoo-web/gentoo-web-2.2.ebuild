# Copyright 1999-2001 Gentoo Technologies, Inc. Distributed under the terms
# of the GNU General Public License, v2 or later 
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/gentoo-web/gentoo-web-2.2.ebuild,v 1.5 2001/07/20 22:36:00 drobbins Exp $
 
S=${WORKDIR}/${P}
DESCRIPTION="www.gentoo.org website"
SRC_URI="http://www.red-bean.com/cvs2cl/cvs2cl.pl"
HOMEPAGE="http://www.gentoo.org"
RDEPEND="sys-devel/python gnome-libs/libxslt net-www/apache-ssl"

src_unpack() {
	if [ "$MAINTAINER" != "yes" ]
	then
		echo "This will zap stuff in /usr/local/httpd/htdocs."
		echo "Beware -- maintainers only."
	fi
}

src_install() {
	dodir /usr/local/httpd/htdocs/doc
	dodir /usr/local/httpd/htdocs/projects
	insinto /usr/local/httpd/htdocs/doc
	cd ${FILESDIR}
	local x
	for x in build desktop xml-guide portage-user gentoo-howto faq nvidia_tsg
	do
		xsltproc xsl/guide-main.xsl xml/${x}.xml > ${D}/usr/local/httpd/htdocs/doc/${x}.html
	done
	dodir /usr/local/httpd/htdocs/images
	insinto /usr/local/httpd/htdocs/images
	cd ${FILESDIR}/images
	doins gtop-new.jpg gbot-new.gif gridtest.gif gentoo-new.gif install*.gif
	insinto /usr/local/httpd/htdocs
	doins favicon.ico
	#dynamic firewalls tools page
	cd ${FILESDIR}
	xsltproc xsl/guide-main.xsl xml/dynfw.xml > ${D}/usr/local/httpd/htdocs/projects/dynfw.html	
	xsltproc xsl/guide-main.xsl xml/project-xml.xml > ${D}/usr/local/httpd/htdocs/projects/xml.html	
	
	insinto /usr/local/httpd/htdocs/projects
	doins dynfw-1.0/dynfw-1.0.tar.gz 
	
	cd ..
	tar czvf ${D}/usr/local/httpd/htdocs/projects/guide-xml-latest.tar.gz files 
	cd ${FILESDIR}
	
	insinto /usr/local/httpd/htdocs

	xsltproc xsl/guide-main.xsl xml/main-about.xml > ${D}/usr/local/httpd/htdocs/index.html
	xsltproc xsl/guide-main.xsl xml/main-download.xml > ${D}/usr/local/httpd/htdocs/index-download.html
	xsltproc xsl/guide-main.xsl xml/main-projects.xml > ${D}/usr/local/httpd/htdocs/index-projects.html
		
	doins css/main-new.css
	
	#install XSL for later use
	dodir /usr/local/httpd/htdocs/xsl
	insinto /usr/local/httpd/htdocs/xsl
	cd ${FILESDIR}/xsl
	doins cvs.xsl guide-main.xsl

	#install snddevices script
	dodir /usr/local/httpd/htdocs/scripts
	insinto /usr/local/httpd/htdocs/scripts
	cd ${FILESDIR}/scripts
	doins snddevices

	dodir /usr/local/httpd/htdocs/wiki/images
	insinto /usr/local/httpd/htdocs/wiki
	cd ${FILESDIR}/wiki
	doins *.php
	cd images
	insinto /usr/local/httpd/htdocs/wiki/images
	doins *.gif
	
	cd ${D}
	chmod -R g+rw,o+r *
	chown -R root.root *

	dobin ${DISTDIR}/cvs2cl.pl
	dosbin ${FILESDIR}/bin/cvslog.sh
	dosbin ${FILESDIR}/bin/wiki.pl
	chmod o-rwx,g+rx ${D}/usr/sbin/wiki.pl
	chown root.dbadmin ${D}/usr/sbin/wiki.pl
}

pkg_preinst() {
	if [ -d /usr/local/httpd/htdocs.bak ]
	then
		rm -rf /usr/local/httpd/htdocs.bak
	fi
	cp -ax /usr/local/httpd/htdocs /usr/local/httpd/htdocs.bak
}

pkg_postinst() {
	source /home/drobbins/.wiki-auth
	cd /usr/local/httpd/htdocs/wiki
	cp functions.php functions.php.orig
	sed -e "s:##USER##:${WIKI_USER}:g" -e "s:##PASS##:${WIKI_PASS}:g" -e "s:##DB##:${WIKI_DB}:g" functions.php.orig > functions.php
	rm functions.php.orig
	cd /usr/sbin
	cp wiki.pl wiki.pl.orig
	sed -e "s:##USER##:${WIKI_USER}:g" -e "s:##PASS##:${WIKI_PASS}:g" -e "s:##DB##:${WIKI_DB}:g" wiki.pl.orig > wiki.pl
	rm wiki.pl.orig
}


