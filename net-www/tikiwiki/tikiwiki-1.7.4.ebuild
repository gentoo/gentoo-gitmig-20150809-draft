# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/tikiwiki/tikiwiki-1.7.4.ebuild,v 1.2 2004/01/27 23:19:42 mholzer Exp $ 

inherit webapp-apache

DESCRIPTION="Full featured Web Content Management System using Php and Smarty Templates"
HOMEPAGE="http://tikiwiki.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
RESTRICT="nomirror"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"

RDEPEND="virtual/php
	media-gfx/graphviz
	dev-db/mysql"

webapp-detect || NO_WEBSERVER=1

pkg_setup() {
	webapp-pkg_setup "${NO_WEBSERVER}"
	einfo "Installing for ${WEBAPP_SERVER}"
}

src_unpack() {
	unpack ${A}
	cd ${S}
}


src_install() {
	webapp-mkdirs

	local DocumentRoot=${HTTPD_ROOT}
	local destdir=${DocumentRoot}/${PN}

	dodir ${destdir}
	cp -r . ${D}${destdir}

	cd ${D}/${HTTPD_ROOT}
	dodoc ${S}/doc/readme.txt
	chown -R ${HTTPD_USER}:${HTTPD_GROUP} ${PN}
}

pkg_postinst() {
	einfo "Tiki requires PHP to have :"
	einfo "    ==> 'memory_limit = 16M'"
	einfo "    ==> 'max_execution_time = 60'"
	einfo "Tiki likes PHP to have :"
	einfo "    ==> 'default_charset = utf-8'"
	einfo "    ==> 'file_uploads enabled = On'"
	einfo "Please edit /etc/php4/php.ini."
	einfo ""
	einfo ""
	einfo "Please read ${HTTPD_ROOT}/${PN}/doc/readme.txt !"
	einfo ""
	einfo "You may find further information on the Tiki website"
	einfo "    ==> http://tikiwiki.org/InstallGettingStarted"
	einfo ""
	einfo ""
	einfo "Now, point your browser to the location of tiki-install.php"
	einfo "    ==> e.g. http://localhost/tikiwiki/tiki-install.php"
	einfo ""
}
