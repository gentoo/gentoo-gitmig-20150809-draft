# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpmd/phpmd-1.1.0.ebuild,v 1.1 2011/03/25 13:47:47 olemarkus Exp $

EAPI="3"
PHP_PEAR_CHANNEL="pear.phpmd.org"
PHP_PEAR_PN="PHP_PMD"
inherit php-pear-lib-r1

DESCRIPTION="PHP mess detector"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
HOMEPAGE="http://www.phpmd.org"

RDEPEND="${RDEPEND}
	dev-php/phpdepend"
