# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/ltris/ltris-1.0.5-r1.ebuild,v 1.4 2004/06/24 23:07:20 agriffis Exp $

inherit games

DESCRIPTION="very polished Tetris clone"
HOMEPAGE="http://lgames.sourceforge.net/"
SRC_URI="mirror://sourceforge/lgames/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE=""

DEPEND=">=media-libs/libsdl-1.1.5
	media-libs/sdl-mixer"

src_compile() {
	egamesconf \
		--with-highscore-path="${GAMES_STATEDIR}" \
		--datadir="${GAMES_DATADIR_BASE}" || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install         || die "make install failed"
	dodoc AUTHORS README TODO ChangeLog || die "dodoc failed"
	prepgamesdirs
}
