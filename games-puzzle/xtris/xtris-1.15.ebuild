# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xtris/xtris-1.15.ebuild,v 1.4 2004/11/05 05:18:10 josejx Exp $

inherit games

S="${WORKDIR}/${PN}"
DESCRIPTION="a networked Tetris-like game"
HOMEPAGE="http://www.iagora.com/~espel/xtris/xtris.html"
SRC_URI="http://www.iagora.com/~espel/xtris/${P}.tar.gz"

KEYWORDS="x86 amd64 ~ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/x11"

src_compile() {
	emake \
		BINDIR="${GAMES_BINDIR}" \
		MANDIR=/usr/share/man \
		XLIBDIR=-L/usr/X11R6/lib \
		CFLAGS="${CFLAGS}" \
			|| die "emake failed"
}

src_install() {
	dogamesbin xtris xtserv xtbot   || die "dogamesbin failed"
	doman xtris.6 xtserv.6 xtbot.6  || die "doman failed"
	dodoc ChangeLog PROTOCOL README || die "dodoc failed"
	prepgamesdirs
}
