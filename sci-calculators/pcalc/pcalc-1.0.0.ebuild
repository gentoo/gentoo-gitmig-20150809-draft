# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/pcalc/pcalc-1.0.0.ebuild,v 1.1 2005/03/30 05:53:42 vapier Exp $

DESCRIPTION="the programmers calculator"
HOMEPAGE="http://ibiblio.org/pub/Linux/apps/math/calc/pcalc.lsm"
SRC_URI="http://ibiblio.org/pub/Linux/apps/math/calc/pcalc-000.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-devel/flex"
RDEPEND=""

S=${WORKDIR}/${PN}-000

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f pcalc
}

src_test() {
	make test || die "make test failed :("
}

src_install() {
	dobin pcalc || die "dobin pcalc"
	dodoc EXAMPLE README
}
