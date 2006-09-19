# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/ampache/ampache-3.3.1.7.ebuild,v 1.4 2006/09/19 00:47:09 dang Exp $

inherit webapp depend.php

DESCRIPTION="Ampache is a PHP-based tool for managing, updating and playing your audio files via a web interface."
HOMEPAGE="http://www.ampache.org/"
SRC_URI="http://www.ampache.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="virtual/httpd-php
	dev-db/mysql"
DEPEND=""

need_php

pkg_setup() {
	webapp_pkg_setup

	require_php_with_use pcre session unicode iconv xml mysql gd zlib
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	webapp_src_preinst

	dodoc ${S}/docs/*
	rm -rf ${S}/docs/*

	cp -R . ${D}${MY_HTDOCSDIR}

	webapp_postinst_txt en ${FILESDIR}/ampache-webinstall.txt
	webapp_src_install
}

