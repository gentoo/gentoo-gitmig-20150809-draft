# Copyright 1999-2001 Gentoo Technologies, Inc. Distributed under the terms
# of the GNU General Public License, v2 or later 
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-doc/gentoo-web/gentoo-web-2.0.ebuild,v 1.4 2001/08/28 04:17:27 lamer Exp $
 
S=${WORKDIR}/${P}
DESCRIPTION="www.gentoo.org website"
SRC_URI=""
HOMEPAGE="http://www.gentoo.org"
RDEPEND="sys-devel/python gnome-libs/libxslt net-www/apache"

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
		xsltproc xsl/guide.xsl xml/${x}.xml > ${D}/usr/local/httpd/htdocs/doc/${x}.html
		chmod 0644 ${D}/usr/local/httpd/htdocs/doc/${x}.html
	done
	doins css/gentoo-doc.css images/gentoo-doc.gif images/install*.gif
	
	#dynamic firewalls tools page
	xsltproc xsl/guide.xsl xml/dynfw.xml > ${D}/usr/local/httpd/htdocs/projects/dynfw.html	
	chmod 0644 ${D}/usr/local/httpd/htdocs/projects/dynfw.html
	
	insinto /usr/local/httpd/htdocs/projects
	doins dynfw-1.0/dynfw-1.0.tar.gz css/gentoo-doc.css images/gentoo-doc.gif

	insinto /usr/local/httpd/htdocs
	doins html/index*.html
	doins css/gentoo-new.css
	cd images
	doins zn* 1x1.gif gmid.gif gtop.jpg favicon.ico
	cd ..
	#exeinto /usr/sbin
	#doexe bin/update-web
	#exeinto /usr/bin
	#doexe bin/pytext
}
	
#pkg_postinst() {
	# This doesn't work, appears to be a path/env-update issue
	#/usr/sbin/update-web
#}


