# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/mana/mana-0.6.1.ebuild,v 1.2 2012/07/03 14:51:52 hasufell Exp $

EAPI=2
inherit eutils cmake-utils games

DESCRIPTION="A fully free and open source MMORPG game client"
HOMEPAGE="http://manasource.org/"
SRC_URI="http://manasource.org/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls opengl server"

RDEPEND="!=games-rpg/tmw-0.5.2
	>=dev-games/physfs-1.0.0
	dev-libs/libxml2
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-image[png]
	media-libs/sdl-net
	media-libs/sdl-ttf
	net-misc/curl
	sys-libs/zlib
	media-libs/libpng:0
	media-fonts/dejavu
	>=dev-games/guichan-0.8.1[sdl]
	media-libs/libsdl[X,opengl?,video]
	media-libs/sdl-gfx
	x11-libs/libX11
	nls? ( virtual/libintl )
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
	server? ( net-libs/enet:1.3 )"

DOCS=( AUTHORS ChangeLog NEWS README )
PATCHES=( "${FILESDIR}"/${P}-gentoo.patch )

src_prepare() {
	base_src_prepare

	if [[ ${LINGUAS+set} ]]; then
		for lang in $(grep -v ^# po/LINGUAS); do
			has $lang $LINGUAS || sed -i "s:^${lang}:#${lang}:" po/LINGUAS
		done
	fi
}

src_compile() {
	cmake-utils_src_compile
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with opengl)
		$(cmake-utils_use_enable nls)
		$(cmake-utils_use_enable server MANASERV)
		-DPKG_DATADIR="${GAMES_DATADIR}/${PN}"
		-DPKG_BINDIR="${GAMES_BINDIR}"
		-DWITH_BUNDLEDHEADERS=OFF
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dosym /usr/share/fonts/dejavu/DejaVuSans-Bold.ttf "${GAMES_DATADIR}"/${PN}/data/fonts/dejavusans-bold.ttf
	dosym /usr/share/fonts/dejavu/DejaVuSans.ttf "${GAMES_DATADIR}"/${PN}/data/fonts/dejavusans.ttf
	dosym /usr/share/fonts/dejavu/DejaVuSansMono.ttf "${GAMES_DATADIR}"/${PN}/data/fonts/dejavusans-mono.ttf
	insinto "${GAMES_DATADIR}"/${PN}/data
	prepgamesdirs
}
