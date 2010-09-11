# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/pingus/pingus-0.7.3.ebuild,v 1.2 2010/09/11 19:50:00 phajdan.jr Exp $

EAPI=2
inherit eutils toolchain-funcs games

DESCRIPTION="free Lemmings clone"
HOMEPAGE="http://pingus.seul.org/"
SRC_URI="http://pingus.seul.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="media-libs/libsdl[joystick,video]
	media-libs/sdl-image[png]
	media-libs/sdl-mixer
	media-libs/libpng
	dev-libs/boost"
DEPEND="${RDEPEND}
	>=dev-util/scons-0.97"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-paths.patch
	sed -i \
		-e "s:GENTOO_BINDIR:${GAMES_BINDIR}:" \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}:" \
		install.sh src/pingus_main.cpp \
		|| die "sed failed"
}

src_configure() {
	scons configure \
		CXX="$(tc-getCXX)" \
		CCFLAGS="${CXXFLAGS}" \
		LINKFLAGS="${LDFLAGS}" \
		|| die "scons configure failed"
}

src_compile() {
	local sconsopts=$(echo "${MAKEOPTS}" | sed -ne "/-j/ { s/.*\(-j[[:space:]]*[0-9]\+\).*/\1/; p }")
	[[ ${MAKEOPTS/-s/} != ${MAKEOPTS} ]] && sconsopts="${sconsopts} -s"

	scons ${sconsopts} || die "scons failed"
}

src_install() {
	./install.sh "${D}" || die "install.sh failed"
	newicon data/images/core/worldmap/pingus_standing.png ${PN}.png
	make_desktop_entry ${PN} Pingus
	dodoc AUTHORS NEWS README TODO
	prepgamesdirs
}
