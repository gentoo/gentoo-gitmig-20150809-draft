# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/phpunit/phpunit-3.0.0.ebuild,v 1.1 2006/11/19 18:16:52 sebastian Exp $

inherit php-pear-lib-r1

DESCRIPTION="Unit Testing framework for PHP 5."
HOMEPAGE="http://www.phpunit.de/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="!dev-php4/phpunit"
RDEPEND=">=dev-lang/php-5.1.4
	>=dev-php5/xdebug-2.0.0_rc1
	>=dev-php/PEAR-Log-1.8.7-r1
	>=dev-php/PEAR-Image_GraphViz-1.2.1
	>=dev-php/PEAR-Testing_Selenium-0.2.1"
SRC_URI="http://pear.phpunit.de/get/PHPUnit-${PV}.tgz"
S="${WORKDIR}/PHPUnit-${PV}"

pkg_setup() {
	require_php_with_use pcre reflection spl xml
}

need_php_by_category
