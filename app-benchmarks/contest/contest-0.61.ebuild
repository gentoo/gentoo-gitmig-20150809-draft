# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/contest/contest-0.61.ebuild,v 1.5 2005/01/01 12:03:38 eradicator Exp $

DESCRIPTION="Test system responsiveness for compare different kernels"
HOMEPAGE="http://members.optusnet.com.au/ckolivas/contest/"
SRC_URI="http://members.optusnet.com.au/ckolivas/contest/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=app-benchmarks/dbench-2.0"

src_unpack () {
	unpack ${A}
	#Removing -g
	sed -i "s:-g::" ${S}/Makefile
	#Adding our cflags
	sed -i "s:-O2:${CFLAGS}:" ${S}/Makefile
}
src_compile() {
	emake || die
}

src_install() {
	dobin contest || die
	doman contest.1
	dodoc README
}
