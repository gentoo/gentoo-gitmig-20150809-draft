# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/stratagus/stratagus-2.2.6-r1.ebuild,v 1.1 2012/05/28 11:54:46 hasufell Exp $

EAPI=2
inherit cmake-utils eutils games

DESCRIPTION="A realtime strategy game engine"
HOMEPAGE="http://stratagus.sourceforge.net/"
SRC_URI="http://launchpad.net/stratagus/trunk/${PV}/+download/stratagus_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bzip2 debug doc mikmod mng theora vorbis"

RDEPEND="dev-db/sqlite:3
	>=dev-lang/lua-5
	dev-lua/toluapp
	media-libs/libpng:0
	virtual/opengl
	x11-libs/libX11
	media-libs/libsdl[audio,opengl,video]
	bzip2? ( app-arch/bzip2 )
	mikmod? ( media-libs/libmikmod )
	mng? ( media-libs/libmng )
	vorbis? ( media-libs/libvorbis
		theora? ( media-libs/libtheora )
	)"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	virtual/pkgconfig"

# on EAPI=4 we would set
# REQUIRED_USE=theora? ( vorbis )

S=${WORKDIR}/${PN}_${PV}.orig

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch \
		"${FILESDIR}"/${P}-debug.patch
}

src_configure() {
	# there are in-source switches
	use debug && CMAKE_BUILD_TYPE=Debug

	local mycmakeargs=(
		-DBINDIR="${GAMES_BINDIR}"
		-DSBINDIR="${GAMES_BINDIR}"
		$(cmake-utils_use_with bzip2 BZIP2)
		$(cmake-utils_use_enable doc DOC)
		$(cmake-utils_use_with mikmod MIKMOD)
		$(cmake-utils_use_with mng MNG)
		$(cmake-utils_use_with vorbis OGGVORBIS)
		$(usex vorbis "$(cmake-utils_use_with theora THEORA)" "-DWITH_THEORA=OFF")
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
