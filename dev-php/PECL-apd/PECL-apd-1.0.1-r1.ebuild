# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PECL-apd/PECL-apd-1.0.1-r1.ebuild,v 1.1 2005/03/01 06:57:57 sebastian Exp $

PHP_EXT_ZENDEXT="yes"
PHP_EXT_PECL_PKG="apd"
PHP_EXT_NAME="apd"
PHP_EXT_INI="yes"

inherit php-ext-pecl

IUSE=""
DESCRIPTION="A full-featured engine-level profiler/debugger."
SLOT="0"
LICENSE="PHP"
KEYWORDS="~x86 ~amd64"
DEPEND="${DEPEND}
	=dev-php/php-5*"

src_install () {
	sed -i 's:/usr/local:/usr:g' ${S}/pprofp || die #83612
	php-ext-pecl_src_install
	dobin pprofp pprof2calltree
	dodoc LICENSE README
}
