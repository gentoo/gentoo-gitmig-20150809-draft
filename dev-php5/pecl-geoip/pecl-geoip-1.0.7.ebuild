# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-geoip/pecl-geoip-1.0.7.ebuild,v 1.1 2009/06/27 23:31:54 robbat2 Exp $

PHP_EXT_NAME="geoip"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README ChangeLog"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="PHP extension to map IP address to geographic places"
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/geoip-1.4.0"
RDEPEND="${DEPEND}"

need_php_by_category
