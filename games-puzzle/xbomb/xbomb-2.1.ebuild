# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xbomb/xbomb-2.1.ebuild,v 1.2 2004/01/05 21:46:25 aliz Exp $

inherit games

DESCRIPTION="Minesweeper clone with hexagonal, rectangular and triangular grid"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/games/strategy/${P}.tgz"
HOMEPAGE="http://www.gedanken.demon.co.uk/xbomb/"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}.diff
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	sed -i -e "s:/usr/bin:${GAMES_BINDIR}:" Makefile
	make DESTDIR=${D} install || die

	prepall
	prepgamesdirs
}
