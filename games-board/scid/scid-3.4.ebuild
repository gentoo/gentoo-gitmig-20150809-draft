# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/scid/scid-3.4.ebuild,v 1.1 2003/09/10 17:46:27 vapier Exp $

inherit games

DESCRIPTION="a free chess database application"
HOMEPAGE="http://scid.sourceforge.net/"
SRC_URI="mirror://sourceforge/scid/${P}.tar.gz
	http://www.visi.com/~veldy/gentoo/scid-extras-08232002.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha ppc sparc"

DEPEND="virtual/glibc
	virtual/x11
	>=dev-lang/tk-8.3
	>=sys-libs/zlib-1.1.3"
RDEPEND="${DEPEND}
	>=dev-lang/python-2.1"

src_compile() {
	./configure \
		COMPILE=c++ \
		LINK=c++ \
		BINDIR=/usr/bin \
		OPTIMIZE="${CXXFLAGS}" \
		TCL_INCLUDE=""

	make || die
}

src_install() {
	dogamesbin scid sc_addmove sc_epgn sc_spell sc_eco sc_import sc_remote \
		sc_tree scidpgn pgnfix pgnscid tkscid tcscid scmerge

	dodoc CHANGES COPYING README THANKS
	dohtml help/*.html

	insinto ${GAMES_DATADIR}/${PN}
	cd ${WORKDIR}
	doins scid.eco spelling.ssp players.img

	prepgamesdirs
}
