# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PECL-crack/PECL-crack-0.1.ebuild,v 1.1 2005/02/17 06:24:33 sebastian Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="crack"
PHP_EXT_NAME="crack"
PHP_EXT_INI="yes"

inherit php-ext-pecl

IUSE=""
DESCRIPTION="PHP interface to the cracklib (libcrack) libraries."
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86"
DEPEND="${DEPEND} sys-libs/cracklib"

src_install () {
	php-ext-pecl_src_install
}
