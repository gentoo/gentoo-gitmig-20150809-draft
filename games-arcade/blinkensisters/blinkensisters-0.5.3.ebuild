# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/blinkensisters/blinkensisters-0.5.3.ebuild,v 1.1 2009/03/14 18:06:23 hanno Exp $

DESCRIPTION="BlinkenSisters - Hunt for the Lost Pixels"
HOMEPAGE="http://www.blinkensisters.org/"
SRC_URI="mirror://sourceforge/${PN}/LostPixels-${PV}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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

S="${WORKDIR}/${PN}"

src_compile() {
	cd "${S}"/lostpixels/game/software/cmake-build
	cmake -DCMAKE_INSTALL_PREFIX=/usr ..
	emake || die "make failed"
}

src_install() {
	cd "${S}"/lostpixels/game/software/cmake-build
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc "${S}"/lostpixels/game/software/DOC/*
}
