# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/contest/contest-0.61.ebuild,v 1.3 2004/05/31 19:46:33 vapier Exp $

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
