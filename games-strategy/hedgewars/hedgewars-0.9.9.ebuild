# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/hedgewars/hedgewars-0.9.9.ebuild,v 1.4 2009/04/06 20:39:24 maekke Exp $

EAPI=2
inherit cmake-utils eutils games

MY_P=${PN}-src-${PV}
DESCRIPTION="Free Worms-like turn based strategy game"
HOMEPAGE="http://hedgewars.org/"
SRC_URI="http://hedgewars.org/download/${MY_P}.tar.bz2"

LICENSE="GPL-2 BitstreamVera"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="|| (
		( x11-libs/qt-gui:4 x11-libs/qt-svg:4 )
		>=x11-libs/qt-4.4:4
	)
	media-libs/libsdl[audio,video]
	media-libs/sdl-ttf
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-image[png]
	media-libs/sdl-net"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6
	>=dev-lang/fpc-2.2"

S=${WORKDIR}/${MY_P}

src_configure() {
	mycmakeargs="-DCMAKE_INSTALL_PREFIX=${GAMES_PREFIX} -DDATA_INSTALL_DIR=${GAMES_DATADIR}"
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	DOCS="ChangeLog.txt README" cmake-utils_src_install
	newicon QTfrontend/res/hh25x25.png ${PN}.png
	make_desktop_entry ${PN} Hedgewars
	doman man/${PN}.6
	prepgamesdirs
}
