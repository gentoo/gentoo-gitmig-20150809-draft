# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PECL-crack/PECL-crack-0.2.ebuild,v 1.1 2005/03/18 05:47:15 sebastian Exp $

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
DEPEND="${DEPEND}
	<sys-libs/cracklib-2.8"
