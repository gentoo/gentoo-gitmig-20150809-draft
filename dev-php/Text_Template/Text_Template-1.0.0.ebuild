# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/Text_Template/Text_Template-1.0.0.ebuild,v 1.1 2012/03/10 15:16:31 olemarkus Exp $

EAPI="4"

PHP_PEAR_CHANNEL="${FILESDIR}/channel.xml"
PHP_PEAR_URI="pear.phpunit.de"
PHP_PEAR_PN="Text_Template"

inherit php-pear-lib-r1

HOMEPAGE="http://pear.phpunit.de"

DESCRIPTION="Simple template engine"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
