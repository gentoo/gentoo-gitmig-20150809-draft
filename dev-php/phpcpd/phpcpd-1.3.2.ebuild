# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpcpd/phpcpd-1.3.2.ebuild,v 1.2 2011/04/16 12:45:40 olemarkus Exp $

EAPI="3"
PHP_PEAR_CHANNEL="${FILESDIR}/channel.xml"
PHP_PEAR_PN="phpcpd"
inherit php-pear-lib-r1

DESCRIPTION="Copy/Paste Detector (CPD) for PHP code"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
HOMEPAGE="http://www.phpunit.de"

RDEPEND="${RDEPEND}
	>=dev-php5/ezc-ConsoleTools-1.6
	>=dev-php/file-iterator-1.1.0"
