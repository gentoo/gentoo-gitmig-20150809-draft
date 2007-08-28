# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/btanks/btanks-0.5.4740-r1.ebuild,v 1.3 2007/08/28 20:22:24 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Fast 2D tank arcade game with multiplayer and split-screen modes"
HOMEPAGE="http://btanks.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-scons-blows.patch
}

src_compile() {
	scons \
		mode="release" \
		prefix=/usr \
		lib_dir="$(games_get_libdir)/${PN}" \
		resources_dir="${GAMES_DATADIR}/${PN}" \
		|| die "scons"
}

src_install() {
	newgamesbin bt btanks || die "newgamesbin"

	insinto "$(games_get_libdir)"/${PN}
	doins lib{mrt,bt,sdlx}.so || die "doins for lib.so failed"

	exeinto "${GAMES_DATADIR}/${PN}"
	doexe libbt_objects.so || die "doins for libbt_objects.so failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data || die "doins for data failed"
	dodoc ChangeLog *.txt

	newicon src/bt.xpm ${PN}.xpm || die "newicon"
	make_desktop_entry ${PN} "Battle Tanks" ${PN}.xpm

	prepgamesdirs
}
