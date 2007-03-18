# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/onphp-module/onphp-module-0.6.4.ebuild,v 1.4 2007/03/18 15:11:49 chtekk Exp $

PHP_EXT_NAME="onphp"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-source-r1

KEYWORDS="amd64 x86"

DESCRIPTION="onPHP's module."
HOMEPAGE="http://onphp.org/"
SRC_URI="http://onphp.org/download/onphp-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="~dev-php5/onphp-${PV}"

S="${WORKDIR}/onphp-${PV}/ext"

need_php_by_category

pkg_setup() {
	has_php
	require_php_with_use reflection spl
}
