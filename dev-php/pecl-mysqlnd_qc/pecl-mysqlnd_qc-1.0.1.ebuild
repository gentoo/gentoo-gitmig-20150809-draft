# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-mysqlnd_qc/pecl-mysqlnd_qc-1.0.1.ebuild,v 1.2 2012/02/14 17:16:27 tove Exp $

PHP_EXT_NAME="mysqlnd_qc"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

EAPI=4

inherit php-ext-pecl-r2

KEYWORDS="~amd64"

DESCRIPTION="A query cache plugin for the mysqlnd library."
LICENSE="PHP-3"
SLOT="0"
IUSE=""

DEPEND="dev-lang/php[mysqlnd]"
RDEPEND="${DEPEND}"
