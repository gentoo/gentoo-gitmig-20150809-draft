# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpunit/phpunit-3.5.14.ebuild,v 1.1 2011/07/30 10:00:16 olemarkus Exp $

EAPI="2"
PHP_PEAR_CHANNEL="${FILESDIR}/channel.xml"
PHP_PEAR_PN="PHPUnit"

PHP_PEAR_URI="pear.phpunit.de"
inherit php-pear-lib-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Unit testing framework for PHP5"
HOMEPAGE="http://www.phpunit.de/"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND=">=dev-php/PEAR-PEAR-1.9.1"
RDEPEND="${DEPEND}
	>=dev-lang/php-5.2.7[simplexml,xml,tokenizer]
	|| ( <dev-lang/php-5.3[pcre,reflection,spl] >=dev-lang/php-5.3 )
	>=dev-php/PEAR-Image_GraphViz-1.2.1
	>=dev-php/PEAR-Log-1.8.7-r1
	>=dev-php/dbunit-1.0.0
	>=dev-php5/PEAR-Text_Template-1.0.0
	>=dev-php/php-codecoverage-1.0.2
	>=dev-php/php-timer-1.0.0
	>=dev-php5/phpunit-mockobject-1.0.3
	>=dev-php5/phpunit-selenium-1.0.1
	>=dev-php/file-iterator-1.2.3
	>=dev-php/yaml-1.0.2"

pkg_postinst() {
	elog "${PN} can optionally use json, pdo-sqlite and pdo-mysql features."
	elog "If you want those, emerge dev-lang/php with USE=\"json pdo sqlite mysql\"."
}
