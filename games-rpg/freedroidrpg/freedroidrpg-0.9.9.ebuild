# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/freedroidrpg/freedroidrpg-0.9.9.ebuild,v 1.2 2004/03/12 10:11:40 mr_bones_ Exp $

inherit games

DESCRIPTION="Freedroid - a Paradroid clone"
HOMEPAGE="http://freedroid.sourceforge.net/"
SRC_URI="mirror://sourceforge/freedroid/${P}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND=">=media-libs/libsdl-1.1.5
	media-libs/jpeg
	sys-libs/zlib
	media-libs/libpng
	media-libs/sdl-image
	media-libs/sdl-net
	media-libs/sdl-mixer
	virtual/x11"

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepgamesdirs
}
