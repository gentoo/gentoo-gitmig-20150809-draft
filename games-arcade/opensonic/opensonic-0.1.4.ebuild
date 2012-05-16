# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/opensonic/opensonic-0.1.4.ebuild,v 1.1 2012/05/16 18:42:50 hasufell Exp $

EAPI=3

inherit cmake-utils eutils games

MY_PN=opensnc
MY_P=${MY_PN}-src-${PV}

DESCRIPTION="A free open-source game based on the Sonic the Hedgehog universe"
HOMEPAGE="http://opensnc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror" # unsure about legality of graphics

DEPEND="media-libs/allegro:0[X,jpeg,png,vorbis]
	media-libs/libogg
	media-libs/libpng:0
	media-libs/libvorbis
	sys-libs/zlib
	virtual/jpeg"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-cmake.patch
}

src_configure() {
	local mycmakeargs=(
		-DGAME_INSTALL_DIR="${GAMES_DATADIR}"/${PN}
		-DGAME_FINAL_DIR="${GAMES_BINDIR}"
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	prepgamesdirs
}
