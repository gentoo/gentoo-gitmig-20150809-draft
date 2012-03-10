# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/DBUnit/DBUnit-1.0.1.ebuild,v 1.1 2012/03/10 16:37:09 olemarkus Exp $

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
	>=dev-php/ezc-ConsoleTools-1.6
	>=dev-php/File_Iterator-1.2.2
	dev-php/PHP_TokenStream
	dev-php/Text_Template"
