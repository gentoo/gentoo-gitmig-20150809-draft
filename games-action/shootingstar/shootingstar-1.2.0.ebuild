# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/shootingstar/shootingstar-1.2.0.ebuild,v 1.5 2007/03/14 20:53:28 nyhm Exp $

inherit eutils games

DESCRIPTION="A topdown shooter"
HOMEPAGE="http://www.2ndpoint.fi/ss"
SRC_URI="http://www.2ndpoint.fi/ss/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-gcc34.patch
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon data/textures/body1.png ${PN}.png
	make_desktop_entry ${PN} "Shooting Star"
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepgamesdirs
}
