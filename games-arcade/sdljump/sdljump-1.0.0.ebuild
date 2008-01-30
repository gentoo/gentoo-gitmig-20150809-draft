# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/sdljump/sdljump-1.0.0.ebuild,v 1.4 2008/01/30 16:06:39 nyhm Exp $

inherit eutils games

DESCRIPTION="Xjump clone with added features"
HOMEPAGE="http://www.gnu.org/software/gnujump/"
SRC_URI="http://download.savannah.gnu.org/releases/gnujump/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	virtual/opengl
	virtual/glu
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's/\\n//' sdljump.6 \
		|| die "sed failed"
	epatch "${FILESDIR}"/${P}-configure.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README

	newicon skins/xjump/hero1.0.png ${PN}.png
	make_desktop_entry ${PN} "SDLjump"

	prepgamesdirs
}
