# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-sdo/pecl-sdo-1.0.4.ebuild,v 1.1 2006/09/29 16:40:12 sebastian Exp $

PHP_EXT_NAME="sdo"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~x86"
DESCRIPTION="Service Data Objects (SDOs) for PHP."
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""
DEPEND="${DEPEND} >=dev-lang/php-5.1.4-r6"
S="${WORKDIR}/SDO-${PV}"

need_php_by_category
