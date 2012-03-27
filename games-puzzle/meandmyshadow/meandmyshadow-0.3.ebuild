# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/meandmyshadow/meandmyshadow-0.3.ebuild,v 1.1 2012/03/27 16:36:20 mr_bones_ Exp $

EAPI=3
inherit eutils cmake-utils games

DESCRIPTION="A puzzle/plateform game with a player and its shadow"
HOMEPAGE="http://meandmyshadow.sourceforge.net/"
SRC_URI="mirror://sourceforge/meandmyshadow/${PV}/${P}-src.tar.gz"

LICENSE="GPL-3 OFL-1.1 CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl[audio,video]
	media-libs/sdl-gfx
	media-libs/sdl-ttf
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-image[png]
	dev-libs/openssl
	net-misc/curl
	app-arch/libarchive"

src_prepare() {
	edos2unix CMakeLists.txt src/config.h.in
	sed -i \
		-e '/Version/s/0.3/1.0/' \
		-e 's/Game;//' \
		meandmyshadow.desktop || die
	epatch "${FILESDIR}"/${P}-cmake.patch
}

src_configure()
{
	mycmakeargs=(
		-DCMAKE_VERBOSE_MAKEFILE=TRUE
		-DCMAKE_INSTALL_PREFIX="${GAMES_PREFIX}"
		-DBINDIR="${GAMES_BINDIR}"
		-DDATAROOTDIR="${GAMES_DATADIR}"
		-DICONDIR=/usr/share/icons
		-DDESKTOPDIR=/usr/share/applications
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	DOCS="Controls.txt" cmake-utils_src_install
	doicon icons/64x64/meandmyshadow.png
	prepgamesdirs
}
