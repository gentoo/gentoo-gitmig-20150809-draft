# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PECL-ps/PECL-ps-1.3.1.ebuild,v 1.1 2005/03/15 09:07:11 sebastian Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="ps"
PHP_EXT_NAME="ps"
PHP_EXT_INI="yes"

inherit php-ext-pecl

IUSE=""
DESCRIPTION="PHP extension for creating PostScript files."
SLOT="0"
LICENSE="PHP"
KEYWORDS="~x86"
DEPEND="${DEPEND}
	dev-libs/pslib"
