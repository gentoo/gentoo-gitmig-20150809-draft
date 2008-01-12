# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/blinkensisters/blinkensisters-0.5.1.ebuild,v 1.1 2008/01/12 22:22:40 wschlich Exp $

inherit flag-o-matic

DESCRIPTION="BlinkenSisters - Hunt for the Lost Pixels"
HOMEPAGE="http://www.blinkensisters.org/"
SRC_URI="mirror://sourceforge/${PN}/LostPixels-${PV}-source.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/sdl-net
	media-libs/sdl-ttf
	media-libs/libogg
	media-libs/libvorbis"
S="${WORKDIR}/${PN}"

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
