# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/stratagus/stratagus-2.2.6.ebuild,v 1.1 2012/05/27 20:24:24 hasufell Exp $

EAPI=2
inherit cmake-utils eutils games

DESCRIPTION="A realtime strategy game engine"
HOMEPAGE="http://stratagus.sourceforge.net/"
SRC_URI="http://launchpad.net/stratagus/trunk/${PV}/+download/stratagus_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bzip2 debug doc mikmod mng theora vorbis"

RDEPEND="x11-libs/libX11
	virtual/opengl
	dev-db/sqlite:3
	>=dev-lang/lua-5
	dev-lua/toluapp
	media-libs/libpng:0
	media-libs/libsdl[audio,opengl,video]
	bzip2? ( app-arch/bzip2 )
	mikmod? ( media-libs/libmikmod )
	mng? ( media-libs/libmng )
	theora? ( media-libs/libtheora media-libs/libvorbis )
	vorbis? ( media-libs/libvorbis )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

S=${WORKDIR}/${PN}_${PV}.orig

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
}

src_configure() {
	local mycmakeargs=(
		-DBINDIR="${GAMES_BINDIR}"
		-DSBINDIR="${GAMES_BINDIR}"
		$(cmake-utils_use_with bzip2)
		$(cmake-utils_use_with debug)
		$(cmake-utils_use_enable doc)
		$(cmake-utils_use_with mikmod)
		$(cmake-utils_use_with mng)
		$(cmake-utils_use_with theora)
		$(cmake-utils_use_with vorbis oggvorbis)
		-DENABLE_DEV=ON
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	prepalldocs
	prepgamesdirs
}
