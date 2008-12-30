# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/contest/contest-0.61.ebuild,v 1.7 2008/12/30 17:26:47 angelos Exp $

inherit toolchain-funcs

DESCRIPTION="Test system responsiveness to compare different kernels"
HOMEPAGE="http://members.optusnet.com.au/ckolivas/contest/"
SRC_URI="http://members.optusnet.com.au/ckolivas/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND=">=app-benchmarks/dbench-2.0"

src_unpack () {
	unpack ${A}
	cd "${S}"

	#Removing -g
	sed -i "s:-g::" Makefile
	#Adding our cflags
	sed -i "s:-O2:${CFLAGS} ${LDFLAGS}:" Makefile
	sed -i -e "/^CC/s/gcc/$(tc-getCC)/" Makefile
}
src_compile() {
	emake || die
}

src_install() {
	dobin contest || die
	doman contest.1
	dodoc README
}
