# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xbomb/xbomb-2.1.ebuild,v 1.1 2003/09/10 06:36:00 vapier Exp $

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
	patch -p0 < ${FILESDIR}/${P}.diff || die
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	cp Makefile Makefile.old
	sed -e "s:/usr/bin:${GAMES_BINDIR}:" Makefile.old > Makefile
	make DESTDIR=${D} install || die

	prepall
	prepgamesdirs
}
