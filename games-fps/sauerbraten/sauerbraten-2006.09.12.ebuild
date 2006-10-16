# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/sauerbraten/sauerbraten-2006.09.12.ebuild,v 1.2 2006/10/16 20:11:58 tupone Exp $

inherit eutils games

DESCRIPTION="free multiplayer/singleplayer first person shooter (major redesign of the Cube FPS)"
HOMEPAGE="http://sauerbraten.org/"
SRC_URI="mirror://sourceforge/sauerbraten/sauerbraten_${PV//./_}_water_edition_linux.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/libpng
	sys-libs/zlib
	virtual/opengl"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	find -name CVS -print0 | xargs -0 rm -rf
}

src_compile() {
	echo eat
}

src_install() {
	exeinto "${GAMES_LIBDIR}"/${PN}
	doexe bin_unix/linux_{client,server} || die

	insinto "${GAMES_DATADIR}"
	doins -r data packages || die

	local x
	for x in client server ; do
		newgamesbin "${FILESDIR}"/wrapper ${PN}_${x}-bin || die
		sed -i \
			-e "s:@GENTOO_GAMESDIR@:${GAMES_DATADIR}:g" \
			-e "s:@GENTOO_EXEC@:${GAMES_LIBDIR}/${PN}/linux_${x}:g" \
			"${D}/${GAMES_BINDIR}"/${PN}_${x}-bin
	done

	dohtml -r README.html docs/*

	make_desktop_entry ${PN}_client-bin ${PN}

	prepgamesdirs
}
