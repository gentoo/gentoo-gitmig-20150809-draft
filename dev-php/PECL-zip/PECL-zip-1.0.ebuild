# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PECL-zip/PECL-zip-1.0.ebuild,v 1.1 2005/03/15 17:35:42 sebastian Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="zip"
PHP_EXT_NAME="zip"
PHP_EXT_INI="yes"

inherit php-ext-pecl

IUSE=""
DESCRIPTION="PHP zip management extension."
SLOT="0"
LICENSE="PHP"
KEYWORDS="~x86"
DEPEND="${DEPEND}
	dev-libs/zziplib"
