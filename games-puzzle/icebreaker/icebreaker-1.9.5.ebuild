# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/icebreaker/icebreaker-1.9.5.ebuild,v 1.2 2004/01/05 21:46:25 aliz Exp $

inherit games

DESCRIPTION="Trap and capture penguins on Antarctica"
HOMEPAGE="http://www.mattdm.org/icebreaker/"
SRC_URI="http://www.mattdm.org/icebreaker/1.9.x/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/x11
	media-libs/libsdl
	media-libs/sdl-mixer"

src_compile() {
	emake \
		prefix=/usr \
		bindir=${GAMES_BINDIR} \
		datadir=${GAMES_DATADIR} \
		highscoredir=${GAMES_STATEDIR} || \
			die "emake failed"
}

src_install() {
	einstall \
		prefix=${D}/usr \
		bindir=${D}${GAMES_BINDIR} \
		datadir=${D}${GAMES_DATADIR} \
		highscoredir=${D}${GAMES_STATEDIR} || die

	dodoc ChangeLog INSTALL README* TODO
	prepgamesdirs
}
