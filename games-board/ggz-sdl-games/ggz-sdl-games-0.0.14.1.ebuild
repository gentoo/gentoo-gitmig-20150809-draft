# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-sdl-games/ggz-sdl-games-0.0.14.1.ebuild,v 1.3 2008/06/16 17:38:51 nixnut Exp $

inherit games-ggz

DESCRIPTION="The SDL versions of the games for GGZ Gaming Zone"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE=""

DEPEND="~dev-games/libggz-${PV}
	~dev-games/ggz-client-libs-${PV}
	media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	virtual/opengl
	x11-libs/libXcursor
	media-fonts/ttf-bitstream-vera"

src_install() {
	dosym /usr/share/fonts/ttf-bitstream-vera \
		/usr/share/ggz/geekgame/fonts
	games-ggz_src_install
}
