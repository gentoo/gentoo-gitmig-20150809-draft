# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/btanks/btanks-0.5.4740.ebuild,v 1.1 2007/08/20 23:41:14 tupone Exp $

inherit eutils games

DESCRIPTION="Fast 2D tank arcade game with multiplayer and split-screen modes"
HOMEPAGE="http://btanks.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-libs/libsigc++-2.0
	media-libs/openal
	media-libs/libsdl
	media-libs/libvorbis
	virtual/opengl
	dev-libs/expat
	media-libs/sdl-image"
DEPEND="${RDEPEND}
	dev-util/scons"

src_compile() {
	scons \
		mode="release" \
		prefix=/usr \
		resources_dir="${GAMES_DATADIR}/${PN}" \
		|| die "scons"
}

src_install() {
	newgamesbin bt ${PN}.bin || die "newgamesbin"

	insinto "$(games_get_libdir)"/${PN}
	doins lib{mrt,bt,sdlx}.so || die "doins for lib.so failed"

	exeinto "${GAMES_DATADIR}/${PN}"
	doexe libbt_objects.so || die "doins for libbt_objects.so failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data || die "doins for data failed"
	dodoc ChangeLog *.txt

	games_make_wrapper ${PN} ${PN}.bin "${GAMES_DATADIR}/${PN}" \
		"$(games_get_libdir)/${PN}"
	newicon src/bt.xpm ${PN}.xpm || die "newicon"
	make_desktop_entry ${PN} "Battle Tanks" ${PN}.xpm

	prepgamesdirs
}
