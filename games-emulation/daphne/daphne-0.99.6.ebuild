# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/daphne/daphne-0.99.6.ebuild,v 1.1 2003/09/09 16:26:49 vapier Exp $

inherit games eutils flag-o-matic
replace-flags -march=i686 -march=i586		# Bug 18807 Comment #11
replace-flags -march=pentium3 -march=i586	# Bug 18807 Comment #4

DESCRIPTION="Laserdisc Arcade Game Emulator"
SRC_URI="http://www.daphne-emu.com/download/${P}-src.tar.gz"
HOMEPAGE="http://www.daphne-emu.com/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="virtual/glibc
	media-libs/libogg
	media-libs/libvorbis
	media-libs/libsdl
	media-libs/sdl-mixer
	sys-libs/zlib"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	cd ${S}/src
	sed -e "s:-march=i686:${CFLAGS}:" Makefile.vars.linux_x86 > Makefile.vars

	# lets make this guy play nice with our filesystem setup
	sed -i "s:pics/:${GAMES_DATADIR}/${PN}/pics/:g" video/video.cpp
	sed -i "s:roms/:${GAMES_DATADIR}/${PN}/roms/:g" game/game.cpp
	sed -i "s:sound/:${GAMES_DATADIR}/${PN}/sound/:g" sound/sound.cpp
	sed -i "s:./lib:${GAMES_LIBDIR}/${PN}/lib:g" io/dll.h
	sed -i "s:daphne_log.txt:/tmp/daphne_log.txt:g" daphne.cpp daphne.h io/error.cpp
	sed -i "s:dapinput.ini:~/.dapinput.ini:" io/input.cpp
}

src_compile() {
	cd ${S}/src
	emake || die "src build failed"
	cd ${S}/src/vldp
	emake -f Makefile.linux || die "vldp build failed"
	cd ${S}/src/vldp2
	egamesconf || die
	emake -f Makefile.linux || die "vldp2 build failed"
}

src_install() {
	dogamesbin daphne
	exeinto ${GAMES_LIBDIR}/${PN}
	doexe libvldp*.so
	dodir ${GAMES_DATADIR}/${PN}
	cp -rf pics sound roms ${D}/${GAMES_DATADIR}/${PN}/
	dodoc doc/*.{ini,txt}
	dohtml -r doc/*
	prepgamesdirs
}
