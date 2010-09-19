# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/pecl-sca_sdo/pecl-sca_sdo-1.2.4-r1.ebuild,v 1.2 2010/09/19 16:40:53 mabi Exp $

EAPI="2"

PHP_EXT_NAME="sdo"
PHP_EXT_PECL_PKG="SCA_SDO"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

inherit eutils php-ext-pecl-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Service Component Architecture (SCA) and Service Data Objects (SDO) for PHP."
LICENSE="Apache-2.0"
SLOT="0"
IUSE="examples"

DEPEND=">=dev-lang/php-5.2[json,soap,xml]
	    || ( <dev-lang/php-5.3[pcre,reflection,spl] >=dev-lang/php-5.3.1 )"
RDEPEND="${DEPEND}"

need_php_by_category

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc44.patch
	epatch "${FILESDIR}/${P}-php53.patch"
}

src_install() {
	php-ext-pecl-r1_src_install

	insinto /usr/share/php5
	doins -r DAS SCA
}
