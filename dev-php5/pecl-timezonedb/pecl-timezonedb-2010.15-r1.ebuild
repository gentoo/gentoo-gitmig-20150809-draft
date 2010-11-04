# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-timezonedb/pecl-timezonedb-2010.15-r1.ebuild,v 1.1 2010/11/04 16:08:55 mabi Exp $

EAPI=3

PHP_EXT_NAME="timezonedb"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r2

DESCRIPTION="Timezone Database to be used with PHP's date and time functions"
LICENSE="PHP-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
