# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/ampache/ampache-3.3.1.ebuild,v 1.1 2005/06/27 00:47:04 marineam Exp $

inherit webapp

DESCRIPTION="Ampache is a PHP-based tool for managing, updating and playing your audio files via a web interface."
HOMEPAGE="http://www.ampache.org/"
SRC_URI="http://www.ampache.org/downloads/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
KEYWORDS="~x86"
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

	docinto docs
	dodoc docs/*
	cp -R . ${D}${MY_HTDOCSDIR}
	webapp_postinst_txt en docs/README
	rm -rf docs/*
	webapp_src_install
}

