# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/cgiirc/cgiirc-0.5.3.ebuild,v 1.1 2004/01/29 15:45:27 mholzer Exp $

inherit webapp-apache

DESCRIPTION="A pearl/CGI program to use IRC from a web browser"
HOMEPAGE="http://cgiirc.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

webapp-detect || NO_SERVER=1

pkg_setup() {
	webapp-pkg_setup "${NO_WEBSERVER}"
	einfo "Installing for ${WEBAPP_SERVER}"
}

src_install() {
	echo "Options ExecCGI" > .htaccess
	dodir "${HTTPD_ROOT}/${PN}"

	cp -r * "${D}/${HTTPD_CGIBIN}/${PN}"
	dodoc README Changelog docs/CHANGES docs/COPYING docs/TODO
}

pkg_postinst() {
	einfo "To configure cgiirc edit"
	einfo "	${HTTPD_ROOT}/${PN}/cgiirc.config"
}
