# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/sauerbraten/sauerbraten-2006.12.04.ebuild,v 1.4 2007/03/29 22:24:11 nyhm Exp $

inherit eutils multilib games

DESCRIPTION="free multiplayer/singleplayer first person shooter (major redesign of the Cube FPS)"
HOMEPAGE="http://sauerbraten.org/"
SRC_URI="mirror://sourceforge/sauerbraten/sauerbraten_${PV//./_}_gui_edition_linux.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x86? (
		media-libs/libsdl
		media-libs/sdl-mixer
		media-libs/sdl-image
		media-libs/libpng
		virtual/opengl
	)
	amd64? (
		app-emulation/emul-linux-x86-soundlibs
		app-emulation/emul-linux-x86-sdl
	)"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	find -name CVS -print0 | xargs -0 rm -rf
}

src_compile() {
	echo eat
}

src_install() {
	use amd64 && multilib_toolchain_setup x86

	exeinto "$(games_get_libdir)"/${PN}
	doexe bin_unix/linux_{client,server} || die

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data packages || die

	local x
	for x in client server ; do
		newgamesbin "${FILESDIR}"/wrapper ${PN}_${x}-bin || die
		sed -i \
			-e "s:@GENTOO_GAMESDIR@:${GAMES_DATADIR}/${PN}:g" \
			-e "s:@GENTOO_EXEC@:$(games_get_libdir)/${PN}/linux_${x}:g" \
			"${D}/${GAMES_BINDIR}"/${PN}_${x}-bin
	done

	dohtml -r README.html docs/*

	make_desktop_entry ${PN}_client-bin ${PN}

	prepgamesdirs
}
