# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/toppler/toppler-1.0.3.ebuild,v 1.2 2004/02/09 22:11:14 mr_bones_ Exp $

inherit games

DESCRIPTION="Reimplemention of Nebulous using SDL"
SRC_URI="mirror://sourceforge/toppler/${P}.tar.gz"
HOMEPAGE="http://toppler.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=media-libs/libsdl-1.2.0
	media-libs/sdl-mixer
	sys-libs/zlib"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL README
	prepgamesdirs
}
