# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/geresh/geresh-0.4.1.ebuild,v 1.10 2007/05/11 19:03:12 dirtyepic Exp $

inherit eutils

DESCRIPTION="A simple multi-lingual console text editor with bidi & utf support"
HOMEPAGE="http://www.typo.co.il/~mooffie/geresh/"
SRC_URI="http://www.typo.co.il/~mooffie/geresh/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="spell"

DEPEND="virtual/libiconv
		dev-libs/fribidi
		sys-libs/ncurses
		spell? ( virtual/aspell-dict )
	   "

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Bug #149758
	epatch "${FILESDIR}"/${P}-gcc4.patch
	# GCC 4.3 header fix
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_install() {
	emake DESTDIR="${D}" install || die
}
