# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-apd/pecl-apd-1.0.1.ebuild,v 1.1 2005/09/10 13:59:53 sebastian Exp $

PHP_EXT_ZENDEXT="yes"
PHP_EXT_PECL_PKG="apd"
PHP_EXT_NAME="apd"
PHP_EXT_INI="yes"

inherit php-ext-pecl-r1

DESCRIPTION="pecl-pdo"

LICENSE="PHP"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_install () {
	sed -i 's:/usr/local:/usr:g' ${S}/pprofp || die #83612
	php-ext-pecl-r1_src_install
	dobin pprofp pprof2calltree
	dodoc LICENSE README
}

need_php_by_category
