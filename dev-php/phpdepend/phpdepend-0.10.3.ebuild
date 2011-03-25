# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpdepend/phpdepend-0.10.3.ebuild,v 1.1 2011/03/25 13:35:51 olemarkus Exp $

EAPI="3"
PHP_PEAR_CHANNEL="pear.pdepend.org"
PHP_PEAR_PN="PHP_Depend"
inherit php-pear-lib-r1

DESCRIPTION="Static code analyser for PHP"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
HOMEPAGE="http://www.pdepend.org"

RDEPEND="${RDEPEND}
	>=dev-lang/php-5.2.3"
