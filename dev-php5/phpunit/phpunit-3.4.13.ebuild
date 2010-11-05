# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/phpunit/phpunit-3.4.13.ebuild,v 1.4 2010/11/05 04:31:34 jer Exp $

EAPI="2"
inherit php-pear-lib-r1

KEYWORDS="~alpha amd64 hppa ~ia64 ~sparc x86"

DESCRIPTION="Unit testing framework for PHP5"
HOMEPAGE="http://www.phpunit.de/"
SRC_URI="http://pear.phpunit.de/get/PHPUnit-${PV}.tgz"
LICENSE="BSD"
SLOT="0"
IUSE="+minimal"

DEPEND="!dev-php4/phpunit
	>=dev-php/PEAR-PEAR-1.8.1"
RDEPEND="${DEPEND}
	>=dev-lang/php-5.2[simplexml,xml,tokenizer]
	|| ( <dev-lang/php-5.3[pcre,reflection,spl] >=dev-lang/php-5.3 )
	!minimal? ( >=dev-php5/xdebug-2.0.5
		>=dev-php/PEAR-Image_GraphViz-1.2.1
		>=dev-php/PEAR-Log-1.8.7-r1
		>=dev-php/PEAR-Testing_Selenium-0.2.0 )"

need_php_by_category

S="${WORKDIR}/PHPUnit-${PV}"

pkg_postinst() {
	has_php
	elog "${PN} can optionally use json, pdo-sqlite and pdo-mysql features."
	elog "If you want those, emerge ${PHP_PKG} with USE=\"json pdo sqlite mysql\"."
	if use minimal; then
		elog "You have enabled the minimal USE flag. If you want to use	features"
		elog "from xdebug, PEAR-Log or PEAR-Testing_Selenium disable the"
		elog "USE flag or emerge the packages manually"
	fi
}
