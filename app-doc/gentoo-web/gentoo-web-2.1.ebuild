# Copyright 1999-2001 Gentoo Technologies, Inc. Distributed under the terms
# of the GNU General Public License, v2 or later 
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/gentoo-web/gentoo-web-2.1.ebuild,v 1.2 2001/05/24 17:01:51 drobbins Exp $
 
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
	for x in install xml-guide portage-user gentoo-howto faq nvidia_tsg
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
	
	insinto /usr/local/httpd/htdocs/projects
	doins dynfw-1.0/dynfw-1.0.tar.gz 

	insinto /usr/local/httpd/htdocs

	xsltproc xsl/guide-main.xsl xml/main-about.xml > ${D}/usr/local/httpd/htdocs/index.html
	xsltproc xsl/guide-main.xsl xml/main-download.xml > ${D}/usr/local/httpd/htdocs/index-download.html
		
	doins css/main-new.css
	
	#install XSL for later use
	dodir /usr/local/httpd/htdocs/xsl
	insinto /usr/local/httpd/htdocs/xsl
	cd ${FILESDIR}/xsl
	doins cvs.xsl guide-main.xsl
	
	cd ${D}
	chmod -R g+rw,o+r *
	chown -R root.root *

	dobin ${DISTDIR}/cvs2cl.pl
	dosbin ${FILESDIR}/bin/cvslog.sh
}
	
#pkg_postinst() {
	# This doesn't work, appears to be a path/env-update issue
	#/usr/sbin/update-web
#}


