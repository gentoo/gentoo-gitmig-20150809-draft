# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/phpunit/phpunit-3.5.0.ebuild,v 1.1 2010/10/04 22:51:07 jokey Exp $

EAPI="2"
inherit php-pear-lib-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Unit testing framework for PHP5"
HOMEPAGE="http://www.phpunit.de/"
SRC_URI="http://pear.phpunit.de/get/PHPUnit-${PV}.tgz"
LICENSE="BSD"
SLOT="0"
IUSE="+minimal"

DEPEND="!dev-php4/phpunit
	>=dev-php/PEAR-PEAR-1.9.1"
RDEPEND="${DEPEND}
	>=dev-lang/php-5.2[simplexml,xml,tokenizer]
	|| ( <dev-lang/php-5.3[pcre,reflection,spl] >=dev-lang/php-5.3 )
	!minimal? ( >=dev-php5/xdebug-2.0.5
		>=dev-php/PEAR-Image_GraphViz-1.2.1
		>=dev-php/PEAR-Log-1.8.7-r1
		dev-php5/PEAR-DbUnit
		dev-php5/PEAR-File_Iterator
		dev-php5/PEAR-PHP_CodeCoverage
		dev-php5/PEAR-PHP_TokenStream
		dev-php5/PEAR-PHP_Timer
		dev-php5/phpunit-mockobject
		dev-php5/phpunit-selenium )"

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
