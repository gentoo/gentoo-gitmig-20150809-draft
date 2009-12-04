# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/widelands/widelands-0.0.14.ebuild,v 1.4 2009/12/04 17:04:52 mr_bones_ Exp $

EAPI=2
inherit toolchain-funcs eutils versionator games

MY_PV=$(get_version_component_range 3)
DESCRIPTION="A game similar to Settlers 2"
HOMEPAGE="http://www.widelands.org/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/build-${MY_PV}/Widelands-Build${MY_PV}-src.7z"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="media-libs/libsdl[video]
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-net
	media-libs/sdl-ttf
	media-libs/sdl-gfx
	media-libs/libpng
	dev-libs/boost
	dev-games/ggz-client-libs"

DEPEND="${RDEPEND}
	app-arch/p7zip
	dev-util/scons"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch

	sed -i \
		-e 's:__ppc__:__PPC__:' src/s2map.cc \
		|| die "sed s2map.cc failed"
}

src_compile() {
	local sconsopts=$(echo "${MAKEOPTS}" | sed -ne "/-j/ { s/.*\(-j[:space:]*[0-9]\+\).*/\1/; p }")

	scons \
		${sconsopts} \
		cxx="$(tc-getCXX)" \
		bindir="${GAMES_BINDIR}" \
		datadir="${GAMES_DATADIR}/${PN}" \
		localedir="${GAMES_DATADIR}/${PN}/locale" \
		extra_compile_flags="${CXXFLAGS}" \
		pretty_compile_output=no \
		|| die "scons failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r campaigns fonts global maps music pics sound tribes txts worlds \
		locale VERSION \
		|| die "doins failed"

	newicon pics/wl-ico-128.png ${PN}.png
	make_desktop_entry ${PN} Widelands

	dodoc ChangeLog CREDITS
	prepgamesdirs
}
