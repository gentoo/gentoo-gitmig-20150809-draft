# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/cvsroot/gentoo-x86/net-www/tiki/tiki-1.6.ebuild

inherit webapp-apache

DESCRIPTION="A Web Based Collaboration Platform"
HOMEPAGE="http://twiki.org/"
SRC_URI="http://twiki.org/swd/TWiki${PV}.tar.gz"

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
	mkdir ${P}
	cd ${S}
	unpack ${A}
	sed -i -e 's:\/home\/httpd:\/var\/www\/localhost\/htdocs:g' lib/TWiki.cfg
	echo "Options ExecCGI" >> bin/.htaccess.txt
}


src_install() {
	webapp-mkdirs

	local DocumentRoot=${HTTPD_ROOT}
	local destdir=${DocumentRoot}/${PN}

	dodir ${destdir}
	cp -r . ${D}${destdir}

	cd ${D}/${HTTPD_ROOT}
	dodoc readme.txt license.txt
	chown -R ${HTTPD_USER}:${HTTPD_GROUP} ${PN}
}

pkg_postinst() {
	einfo "now go to your ${HTTPD_ROOT},"
	einfo "copy bin/.htaccess.txt to bin/.htaccess"
	einfo "and edit the paths"
}
