# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-zip/pecl-zip-1.0.ebuild,v 1.4 2005/11/02 00:01:51 vapier Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_PECL_PKG="zip"
PHP_EXT_NAME="zip"
PHP_EXT_INI="yes"

inherit php-ext-pecl-r1

IUSE=""
DESCRIPTION="PHP zip management extension."
SLOT="0"
LICENSE="PHP"
KEYWORDS="~amd64 ~arm ~ppc ~s390 ~sparc ~x86"
DEPEND="${DEPEND}
		dev-libs/zziplib"

need_php_by_category
