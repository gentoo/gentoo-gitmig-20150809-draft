# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/hedgewars/hedgewars-0.9.3.ebuild,v 1.1 2008/04/29 19:20:48 nyhm Exp $

inherit eutils qt4 games

MY_P=${PN}-src-${PV}
DESCRIPTION="Free Worms-like turn based strategy game"
HOMEPAGE="http://hedgewars.org/"
SRC_URI="http://hedgewars.org/download/${MY_P}.tar.bz2"

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
	dev-lang/fpc"

S=${WORKDIR}/${MY_P}

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
	dodoc ChangeLog.txt README
	doman man/${PN}.6
	prepgamesdirs
}
