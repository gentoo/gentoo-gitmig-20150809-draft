# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/ioncube_loaders/ioncube_loaders-2.4.ebuild,v 1.1 2004/01/05 03:39:20 robbat2 Exp $

MY_P="${PN}"
PHP_VER="4.3"

DESCRIPTION="PHP extension that support for running PHP scripts encoded with ionCube's encoder"
HOMEPAGE="http://www.ioncube.com/"
IONCUBE_URL="http://www.ioncube.com/loader_download.php?atype=gz&loader_os[]=linux_i386&php_version[]=${PHP_VER}&form_name=loaders"
SRC_URI="${MY_P}.tar.gz"
LICENSE="${PN}"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/php
	!dev-php/turck-mmcache"
S="${WORKDIR}/ioncube"
RESTRICT="nomirror fetch nostrip"

PHP_EXT_NAME="ioncube_loader_lin_${PHP_VER}"
PHP_EXT_ZENDEXT=1

PHP_LIB_DIR="/usr/lib/php/${PN}"

inherit php-ext-base

pkg_nofetch () {
	einfo "Please download the ionCube loaders from:"
	einfo "${IONCUBE_URL}"
}

src_install() {
	insinto ${EXT_DIR}
	doins ${PHP_EXT_NAME}.so
	dodoc README

	insinto "${PHP_LIB_DIR}"
	doins ioncube-rtl-tester.php

	php-ext-base_src_install
}

pkg_config () {
	einfo "Please remember to create the 'ioncube' directory as documented"
	einfo "in /usr/share/doc/${P}/README."
	einfo
	einfo "The ioncube loader runtime test script has been installed into"
	einfo "${PHP_LIB_DIR}/ioncube-rtl-tester.php"
}
