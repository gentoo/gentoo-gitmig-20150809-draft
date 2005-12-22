# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/aldo/aldo-0.0.11.ebuild,v 1.8 2005/12/22 18:58:31 vanquirius Exp $

inherit eutils toolchain-funcs

DESCRIPTION="a morse tutor"
HOMEPAGE="http://aldo.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	# compile with gcc 3.4, bug 116223
	epatch "${FILESDIR}"/${P}-iostream.diff
}

src_compile() {
	# use our compiler
	export CXX="$(tc-getCXX)"

	make libs || die
	make aldo || die
}

src_install() {
	dobin aldo || die
	dodoc README* TODO VERSION AUTHORS ChangeLog
}
