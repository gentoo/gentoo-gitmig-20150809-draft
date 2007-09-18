# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/hedgewars/hedgewars-0.9.0-r1.ebuild,v 1.1 2007/09/18 21:59:21 nyhm Exp $

inherit eutils qt4 games

DESCRIPTION="Free Worms-like turn based strategy game"
HOMEPAGE="http://hedgewars.org/"
SRC_URI="http://hedgewars.org/download/${PN}-src-${PV}.tar.bz2
	http://hedgewars.org/download/${P}-r2.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="$(qt4_min_version 4.2)
	media-libs/libsdl
	media-libs/sdl-ttf
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/sdl-net"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.4
	>=dev-lang/fpc-1.9.4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${WORKDIR}"/${P}-r2.patch \
		"${FILESDIR}"/${P}-debug-file.patch \
		"${FILESDIR}"/${P}-net.patch
}

src_compile() {
	cmake \
		-DCMAKE_CXX_FLAGS="${CXXFLAGS}" \
		-DCMAKE_INSTALL_PREFIX="${GAMES_PREFIX}" \
		-DDATA_INSTALL_DIR="${GAMES_DATADIR}" \
		. || die "cmake failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon QTfrontend/res/hh25x25.png ${PN}.png
	make_desktop_entry ${PN} Hedgewars
	dodoc README
	prepgamesdirs
}
