# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/skystreets/skystreets-0.2.2.ebuild,v 1.1 2004/01/16 06:57:11 mr_bones_ Exp $

inherit games

DESCRIPTION="A clone of the old dos Skyroads game"
HOMEPAGE="http://skystreets.kaosfusion.com/"
SRC_URI="http://skystreets.kaosfusion.com/${P}.tar.bz2"

KEYWORDS="x86"
LICENSE="OSL-2.0"
SLOT="0"
IUSE=""

DEPEND="virtual/opengl
	media-libs/libsdl
	media-libs/sdl-image"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS BUGS CODE ChangeLog README TODO || die "dodoc failed"
	prepgamesdirs
}
