# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/dbunit/dbunit-1.0.1.ebuild,v 1.9 2011/09/18 10:53:55 olemarkus Exp $

EAPI="3"
PHP_PEAR_CHANNEL="${FILESDIR}/channel.xml"
PHP_PEAR_URI="pear.phpunit.de"
PHP_PEAR_PN="DbUnit"
inherit php-pear-lib-r1

DESCRIPTION="DbUnit port for PHP/PHPUnit"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
HOMEPAGE="http://www.phpunit.de"

RDEPEND="${RDEPEND}
	!!<dev-php/phpunit-3.5
	>=dev-php5/ezc-ConsoleTools-1.6
	>=dev-php/file-iterator-1.2.2
	dev-php/php-tokenstream
	dev-php/php-texttemplate"
