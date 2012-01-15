# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-mysqlnd_ms/pecl-mysqlnd_ms-1.1.2.ebuild,v 1.2 2012/01/15 19:50:03 tove Exp $

PHP_EXT_NAME="mysqlnd_ms"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

EAPI=4

inherit php-ext-pecl-r2

KEYWORDS="~amd64"

DESCRIPTION="A replication and load balancing plugin for the mysqlnd library."
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND="dev-lang/php[mysqlnd]"
RDEPEND="${DEPEND}"
