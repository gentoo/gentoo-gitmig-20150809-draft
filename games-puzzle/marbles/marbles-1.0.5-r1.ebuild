# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/marbles/marbles-1.0.5-r1.ebuild,v 1.1 2003/09/10 06:36:00 vapier Exp $

inherit games

DESCRIPTION="puzzle game inspired by Atomix and written in SDL"
HOMEPAGE="http://lgames.sourceforge.net/index.php?project=Marbles"
SRC_URI="mirror://sourceforge/lgames/${P}.tar.gz"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/sdl-mixer-1.2.3"

src_compile() {
	egamesconf --datadir="${GAMES_DATADIR_BASE}" || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL README TODO
	prepgamesdirs
}
