# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/blinkensisters/blinkensisters-0.5.1.ebuild,v 1.3 2008/11/18 01:34:58 flameeyes Exp $

inherit flag-o-matic

DESCRIPTION="BlinkenSisters - Hunt for the Lost Pixels"
HOMEPAGE="http://www.blinkensisters.org/"
SRC_URI="mirror://sourceforge/${PN}/LostPixels-${PV}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/sdl-net
	media-libs/sdl-ttf
	media-libs/libogg
	media-libs/libvorbis"
DEPEND="${RDEPEND}
	dev-util/cmake"

S=${WORKDIR}/${PN}

src_compile() {
	cd "${S}"/lostpixels/game/software/cmake-build
	cmake ..
	emake || die "make failed"
}

src_install() {
	cd "${S}"/lostpixels/game/software/cmake-build
	sed -e 's#CMAKE_INSTALL_PREFIX "/usr/local"#CMAKE_INSTALL_PREFIX "/usr"#' \
		cmake_install.cmake > cmake_install.cmake.tmp \
		&& mv -f cmake_install.cmake.tmp cmake_install.cmake
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc "${S}"/lostpixels/game/software/DOC/*
}
