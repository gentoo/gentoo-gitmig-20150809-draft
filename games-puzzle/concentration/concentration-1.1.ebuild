# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/concentration/concentration-1.1.ebuild,v 1.2 2004/03/21 15:28:06 dholm Exp $

inherit games

DESCRIPTION="The classic memory game with some new life"
HOMEPAGE="http://www.shiftygames.com/concentration/concentration.html"
SRC_URI="http://www.shiftygames.com/concentration/${P}.tar.gz"

KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2
	>=media-libs/sdl-mixer-1.2
	>=media-libs/sdl-image-1.2
	media-libs/sdl-ttf"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog
	prepgamesdirs
}
