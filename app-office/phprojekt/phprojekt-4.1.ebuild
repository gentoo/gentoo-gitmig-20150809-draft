# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/phprojekt/phprojekt-4.1.ebuild,v 1.2 2004/04/21 18:58:10 mholzer Exp $

inherit webapp-apache

DESCRIPTION="Project management and coordination system"
HOMEPAGE="http://www.phprojekt.com/"
IUSE="apache2"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

RDEPEND="virtual/php"

pkg_setup() {
	webapp-detect || NO_WEBSERVER=1
	webapp-pkg_setup "${NO_WEBSERVER}"
	einfo "Installing into ${ROOT}${HTTPD_ROOT}."
}

src_install() {
	webapp-mkdirs

	local DocumentRoot=${HTTPD_ROOT}
	local destdir=${DocumentRoot}/${PN}

	dodoc ChangeLog install readme
	dodir ${destdir}
	cp -r . ${D}${destdir}
	cd ${D}/${HTTPD_ROOT}
	chown -R ${HTTPD_USER}:${HTTPD_GROUP} ${PN}
}
