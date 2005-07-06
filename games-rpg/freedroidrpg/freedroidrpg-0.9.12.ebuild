# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/freedroidrpg/freedroidrpg-0.9.12.ebuild,v 1.6 2005/07/06 22:38:31 mr_bones_ Exp $

inherit games

DESCRIPTION="A modification of the classical Freedroid engine into an RPG"
HOMEPAGE="http://freedroid.sourceforge.net/"
SRC_URI="mirror://sourceforge/freedroid/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND=">=media-libs/libsdl-1.1.5
	media-libs/jpeg
	sys-libs/zlib
	media-libs/libpng
	media-libs/sdl-image
	media-libs/sdl-net
	media-libs/sdl-mixer
	virtual/x11"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepgamesdirs
}
