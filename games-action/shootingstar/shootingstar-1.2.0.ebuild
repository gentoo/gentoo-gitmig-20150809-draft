# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/shootingstar/shootingstar-1.2.0.ebuild,v 1.3 2004/07/26 21:53:12 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="A topdown shooter"
HOMEPAGE="http://www.2ndpoint.fi/ss"
SRC_URI="http://www.2ndpoint.fi/ss/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/x11
	virtual/opengl
	virtual/glu
	>=media-libs/libsdl-1.2
	media-libs/sdl-mixer
	media-libs/sdl-image"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/1.2.0-gcc34.patch"
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepgamesdirs
}
