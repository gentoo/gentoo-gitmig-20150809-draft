# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/slimevolley/slimevolley-2.4.1-r1.ebuild,v 1.3 2010/06/21 20:13:00 maekke Exp $

EAPI=2
inherit cmake-utils eutils games

DESCRIPTION="A simple volleyball game"
HOMEPAGE="http://slime.tuxfamily.org/index.php"
SRC_URI="http://downloads.tuxfamily.org/slime/debian/dists/stable/main/source/${PN}_${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="net"

RDEPEND="media-libs/libsdl[X,audio,video]
	media-libs/sdl-ttf
	media-libs/sdl-image[png]
	net? ( media-libs/sdl-net )
	virtual/libintl"
DEPEND="${RDEPEND}
	sys-devel/gettext"

DOCS="CREDIT proto_reseau.txt README sv_portable.txt TODO"

src_prepare() {
	sed -i \
		-e '/^Encoding/d' \
		debian/${PN}.desktop || die

	sed -i \
		-e "/DESTINATION/s:games:${GAMES_BINDIR}:" \
		CMakeLists.txt || die
	epatch "${FILESDIR}"/${P}-nodatalocal.patch # bug #318005
}

src_configure() {
	mycmakeargs=(
	"-DCMAKE_VERBOSE_MAKEFILE=TRUE"
	$(use net && echo "-DNO_NET=0" || echo "-DNO_NET=1")
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	prepgamesdirs
}
