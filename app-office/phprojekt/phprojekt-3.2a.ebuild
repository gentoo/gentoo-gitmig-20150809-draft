# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/phprojekt/phprojekt-3.2a.ebuild,v 1.2 2002/08/06 18:17:31 gerk Exp $

# lid of download link
MY_DOWNLOAD_ID=14

HTTPD_ROOT=/home/httpd/htdocs
HTTPD_USER=apache
HTTPD_GROUP=apache

DESCRIPTION="Project management and coordination system"
HOMEPAGE="http://www.phprojekt.com"
SRC_URI="http://www.phprojekt.de/download/${PN}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

RDEPEND="virtual/php"
DEPEND=""

S="${WORKDIR}/${P}"

src_compile() {
	echo "nothing to compile"
}

src_install () {
	dodoc ChangeLog install readme
	dodir ${HTTPD_ROOT}/phprojekt
	cp -r . ${D}/${HTTPD_ROOT}/phprojekt
	cd ${D}/${HTTPD_ROOT}
	chown -R ${HTTPD_USER}:${HTTPD_GROUP} phprojekt
}
