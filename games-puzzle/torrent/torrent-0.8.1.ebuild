# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/torrent/torrent-0.8.1.ebuild,v 1.2 2004/04/30 11:27:53 dholm Exp $

inherit games

DESCRIPTION="Match rising tiles to score as many points as possible before the tiles touch the top of the board"
HOMEPAGE="http://www.shiftygames.com/torrent/torrent.html"
SRC_URI="http://www.shiftygames.com/torrent/${P}.tar.gz"

KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-libs/libsdl-1.2.4
	>=media-libs/sdl-mixer-1.2
	>=media-libs/sdl-image-1.2
	media-libs/sdl-ttf"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog
	prepgamesdirs
}
