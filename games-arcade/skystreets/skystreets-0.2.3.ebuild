# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/skystreets/skystreets-0.2.3.ebuild,v 1.1 2004/03/30 10:51:56 mr_bones_ Exp $

inherit games

DESCRIPTION="A clone of the old dos Skyroads game"
HOMEPAGE="http://skystreets.kaosfusion.com/"
SRC_URI="http://skystreets.kaosfusion.com/${P}.tar.bz2"

LICENSE="OSL-2.0"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/opengl
	media-libs/libsdl
	media-libs/sdl-image"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS CODE ChangeLog README TODO
	prepgamesdirs
}
