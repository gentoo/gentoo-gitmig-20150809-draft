# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/phpunit/phpunit-3.4.6-r1.ebuild,v 1.1 2010/02/19 14:30:10 reavertm Exp $

inherit php-pear-lib-r1

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~sparc ~x86"

DESCRIPTION="Unit testing framework for PHP5"
HOMEPAGE="http://www.phpunit.de/"
SRC_URI="http://pear.phpunit.de/get/PHPUnit-${PV}.tgz"
LICENSE="BSD"
SLOT="0"
IUSE="minimal"

DEPEND="!dev-php4/phpunit
	>=dev-php/PEAR-PEAR-1.8.1"
RDEPEND="${DEPEND}
	!minimal? ( >=dev-php5/xdebug-2.0.5
		>=dev-php/PEAR-Image_GraphViz-1.2.1
		>=dev-php/PEAR-Log-1.8.7-r1
		>=dev-php/PEAR-Testing_Selenium-0.2.0 )"

S="${WORKDIR}/PHPUnit-${PV}"

need_php_by_category

pkg_setup() {
	require_php_with_use pcre reflection simplexml spl xml tokenizer
}

pkg_postinst() {
	has_php
	elog "${PN} can optionally use json, pdo-sqlite and pdo-mysql features."
	elog "If you want those, emerge ${PHP_PKG} with USE=\"json pdo sqlite mysql\"."
}
