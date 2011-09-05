# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/tmw/tmw-0.5.2.ebuild,v 1.2 2011/09/05 18:02:37 mr_bones_ Exp $

EAPI=2
inherit eutils cmake-utils games

MUSIC=tmwmusic-0.3

DESCRIPTION="A fully free and open source MMORPG game with the looks of \"old-fashioned\" 2D RPG"
HOMEPAGE="http://themanaworld.org/"
SRC_URI="mirror://sourceforge/themanaworld/${P}.tar.bz2
	mirror://sourceforge/themanaworld/${MUSIC}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND=">=dev-games/physfs-1.0.0
	dev-libs/libxml2
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-image[png]
	media-libs/sdl-net
	media-libs/sdl-ttf
	net-misc/curl
	sys-libs/zlib
	media-libs/libpng
	media-fonts/dejavu
	>=dev-games/guichan-0.8.1[sdl]
	media-libs/libsdl[opengl,video]
	media-libs/sdl-gfx
	x11-libs/libX11
	nls? ( virtual/libintl )
	virtual/opengl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

DOCS=( AUTHORS ChangeLog NEWS README )
PATCHES=( "${FILESDIR}"/${P}-gentoo.patch )

src_unpack() {
	mkdir ${P}
	cd ${P}
	unpack ${A}
}

src_prepare() {
	base_src_prepare
	sed -i \
		-e "s:@GENTOO_BINDIR@:${GAMES_BINDIR}:" \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		CMakeLists.txt \
		|| die "sed failed"
}

src_configure() {
	mycmakeargs=(
		-DWITH_OPENGL=ON
		$(cmake-utils_use_enable nls)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dosym /usr/share/fonts/dejavu/DejaVuSans-Bold.ttf "${GAMES_DATADIR}"/${PN}/data/fonts/dejavusans-bold.ttf
	dosym /usr/share/fonts/dejavu/DejaVuSans.ttf "${GAMES_DATADIR}"/${PN}/data/fonts/dejavusans.ttf
	insinto "${GAMES_DATADIR}"/${PN}/data
	doins -r ${MUSIC}/data/music || die
	prepgamesdirs
}
