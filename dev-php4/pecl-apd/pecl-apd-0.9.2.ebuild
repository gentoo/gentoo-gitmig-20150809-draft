# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php4/pecl-apd/pecl-apd-0.9.2.ebuild,v 1.1 2005/09/18 13:55:15 hollow Exp $

PHP_EXT_ZENDEXT="yes"
PHP_EXT_PECL_PKG="apd"
PHP_EXT_NAME="apd"
PHP_EXT_INI="yes"

inherit php-ext-pecl-r1

IUSE=""
DESCRIPTION="A full-featured engine-level profiler/debugger."
SLOT="0"
LICENSE="PHP"
KEYWORDS="~x86"

need_php_by_category

src_install () {
	sed -i 's:/usr/local:/usr:g' ${S}/pprofp || die #83612
	php-ext-pecl-r1_src_install
	dobin pprofp
	dodoc LICENSE README
}
