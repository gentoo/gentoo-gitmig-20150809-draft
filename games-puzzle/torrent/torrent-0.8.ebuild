# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/torrent/torrent-0.8.ebuild,v 1.1 2004/03/05 09:16:25 mr_bones_ Exp $

inherit games

DESCRIPTION="Match rising tiles to score as many points as possible before the tiles touch the top of the board"
HOMEPAGE="http://www.shiftygames.com/torrent/torrent.html"
SRC_URI="http://www.shiftygames.com/torrent/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-mixer-1.2
	>=media-libs/sdl-image-1.2
	media-libs/sdl-ttf"

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--datadir=${GAMES_DATADIR_BASE} \
		|| die
	emake || die "emake faile"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	prepgamesdirs
}
