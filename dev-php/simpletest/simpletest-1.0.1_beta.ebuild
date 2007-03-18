# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/simpletest/simpletest-1.0.1_beta.ebuild,v 1.1 2007/03/18 15:57:39 chtekk Exp $

inherit php-lib-r1

KEYWORDS="~amd64 ~x86"

DESCRIPTION="A PHP testing framework."
HOMEPAGE="http://www.lastcraft.com/simple_test.php"
SRC_URI="mirror://sourceforge/simpletest/${PN}_${PV/_/}.tar.gz"
LICENSE="OGTSL"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${PN}"

need_php_by_category

src_install() {
	php-lib-r1_src_install . `find . -type f -print`
}
