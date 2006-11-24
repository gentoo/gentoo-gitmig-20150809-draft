# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-sca_sdo/pecl-sca_sdo-1.1.0.ebuild,v 1.1 2006/11/24 15:47:33 sebastian Exp $

PHP_EXT_NAME="sdo"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit php-ext-pecl-r1

KEYWORDS="~amd64 ~x86"
DESCRIPTION="Service Component Architecture (SCA) and Service Data Objects (SDO) for PHP."
HOMEPAGE="http://www.osoa.org/display/PHP/SOA+PHP+Homepage"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/php-5.1.4-r6"
RDEPEND="${DEPEND}"

S="${WORKDIR}/SCA_SDO-${PV}"

need_php_by_category

pkg_setup() {
	has_php

	require_php_with_use reflection spl xml
}

src_install() {
	php-ext-pecl-r1_src_install

	dodir /usr/share/php5
	insinto /usr/share/php5
	doins -r DAS SCA
}
