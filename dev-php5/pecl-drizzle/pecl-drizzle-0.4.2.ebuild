# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-drizzle/pecl-drizzle-0.4.2.ebuild,v 1.3 2010/10/15 14:58:01 flameeyes Exp $

PHP_EXT_NAME="drizzle"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64"

DESCRIPTION="PHP extension using libdrizzle library to provide communcation with Drizzle and MySQL databases"
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND="dev-db/drizzle"
RDEPEND="${DEPEND}"

need_php_by_category
