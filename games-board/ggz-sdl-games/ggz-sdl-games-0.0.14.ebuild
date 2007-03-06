# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-sdl-games/ggz-sdl-games-0.0.14.ebuild,v 1.2 2007/03/06 12:06:36 nyhm Exp $

inherit games-ggz

DESCRIPTION="The SDL versions of the games for GGZ Gaming Zone"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="~dev-games/ggz-client-libs-${PV}
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	virtual/opengl
	x11-libs/libXcursor
	media-fonts/ttf-bitstream-vera"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's: 3D:3D:' ttt3d/module.dsc.in \
		|| die "sed failed"
}

src_install() {
	dosym /usr/share/fonts/ttf-bitstream-vera \
		/usr/share/ggz/geekgame/fonts
	games-ggz_src_install
}
