# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/phpunit/phpunit-3.0.5.ebuild,v 1.3 2007/08/13 09:49:51 jokey Exp $

inherit php-pear-lib-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Unit Testing framework for PHP 5."
HOMEPAGE="http://www.phpunit.de/"
SRC_URI="http://pear.phpunit.de/get/PHPUnit-${PV}.tgz"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="!dev-php4/phpunit"
RDEPEND="${DEPEND}
		>=dev-php5/xdebug-2.0.0_rc2
		>=dev-php/PEAR-Image_GraphViz-1.2.1
		>=dev-php/PEAR-Log-1.8.7-r1
		>=dev-php/PEAR-Testing_Selenium-0.2.0"

S="${WORKDIR}/PHPUnit-${PV}"

need_php_by_category

pkg_setup() {
	has_php
	require_php_with_use pcre reflection spl xml tokenizer
}
