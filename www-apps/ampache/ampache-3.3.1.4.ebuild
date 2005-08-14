# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/ampache/ampache-3.3.1.4.ebuild,v 1.1 2005/08/14 23:11:23 marineam Exp $

inherit webapp

DESCRIPTION="Ampache is a PHP-based tool for managing, updating and playing your audio files via a web interface."
HOMEPAGE="http://www.ampache.org/"
SRC_URI="http://www.ampache.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND="net-www/apache
	dev-php/php
	dev-db/mysql"
DEPEND=""

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	webapp_src_preinst

	dodoc ${S}/docs/*
	rm -rf ${S}/docs/*

	cp -R . ${D}${MY_HTDOCSDIR}

	webapp_postinst_txt en ${FILESDIR}/${P}-webinstall.txt
	webapp_src_install
}

