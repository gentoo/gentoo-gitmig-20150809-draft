# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/violetland/violetland-0.4.3.ebuild,v 1.5 2012/11/06 08:53:49 tupone Exp $

EAPI=2
inherit eutils multilib toolchain-funcs flag-o-matic boost-utils cmake-utils games

DESCRIPTION="Help a girl by name of Violet to struggle with hordes of monsters."
HOMEPAGE="http://code.google.com/p/violetland/"
SRC_URI="http://violetland.googlecode.com/files/${PN}-v${PV}-src.zip"

LICENSE="GPL-3 CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="media-libs/libsdl[audio,video]
	media-libs/sdl-image[png]
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-ttf
	dev-libs/boost
	virtual/opengl
	virtual/glu"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${PN}-v${PV}

src_prepare() {
	sed -i \
		-e "/README_EN.TXT/d" \
		-e "/README_RU.TXT/d" \
		CMakeLists.txt || die "sed failed"
	epatch "${FILESDIR}"/${P}-boost150.patch

	append-cxxflags -I$(boost-utils_get_includedir)
	append-ldflags -L$(boost-utils_get_libdir)
	export BOOST_INCLUDEDIR=$(boost-utils_get_includedir)
	export BOOST_LIBRARYDIR=-L$(boost-utils_get_libdir)
}

src_configure() {
	mycmakeargs=(
		"-DCMAKE_INSTALL_PREFIX=${GAMES_PREFIX}"
		"-DDATA_INSTALL_DIR=${GAMES_DATADIR}"
		)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	DOCS="README_EN.TXT CHANGELOG" cmake-utils_src_install
	newicon icon-light.png ${PN}.png
	make_desktop_entry ${PN} VioletLand
	prepgamesdirs
}
