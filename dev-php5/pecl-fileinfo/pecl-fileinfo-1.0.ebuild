# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-fileinfo/pecl-fileinfo-1.0.ebuild,v 1.1 2005/09/04 16:24:49 stuart Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="Fileinfo"
PHP_EXT_NAME="fileinfo"
PHP_EXT_INI="yes"

inherit php-ext-pecl-r1

IUSE=""
DESCRIPTION="libmagic bindings for PHP."
SLOT="0"
LICENSE="PHP"
KEYWORDS="~ppc ~x86"
DEPEND="${DEPEND}
		sys-apps/file"

need_php_by_category
