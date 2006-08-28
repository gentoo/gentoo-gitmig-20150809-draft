# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/daphne/daphne-0.99.6-r2.ebuild,v 1.10 2006/08/28 01:53:27 tupone Exp $

inherit eutils flag-o-matic games

DESCRIPTION="Laserdisc Arcade Game Emulator"
HOMEPAGE="http://www.daphne-emu.com/"
SRC_URI="http://www.daphne-emu.com/download/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="media-libs/libogg
	media-libs/libvorbis
	media-libs/libsdl
	media-libs/sdl-mixer
	sys-libs/zlib"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	replace-cpu-flags i686 pentium3 pentium4 i586 #18807

	cd "${S}"
	epatch "${FILESDIR}/${P}"-gcc41.patch
	cd src
	sed \
		-e "/^DFLAGS/d" \
		-e "/-fexpensive-optimizations/d " \
		-e "s/\${DFLAGS}/${CFLAGS}/g" \
		Makefile.vars.linux_x86 > Makefile.vars \
		|| die "sed failed"

	# lets make this guy play nice with our filesystem setup
	sed -i \
		-e "s:pics/:${GAMES_DATADIR}/${PN}/pics/:g" \
		video/video.cpp \
		|| die "sed failed"
	sed -i \
		-e "s:roms/:${GAMES_DATADIR}/${PN}/roms/:g" \
		game/game.cpp \
		|| die "sed failed"
	sed -i \
		-e "s:sound/:${GAMES_DATADIR}/${PN}/sound/:g" \
		sound/sound.cpp \
		|| die "sed failed"
	sed -i \
		-e "s:./lib:${GAMES_LIBDIR}/${PN}/lib:g" \
		io/dll.h \
		|| die "sed failed"
	sed -i \
		-e 's:daphne_log.txt:/tmp/daphne_log.txt:g' \
		daphne.cpp daphne.h io/error.cpp \
		|| die "sed failed"
	epatch "${FILESDIR}/${PV}-local-dapinput.patch"
}

src_compile() {
	cd "${S}/src"
	emake || die "src build failed"
	cd "${S}/src/vldp"
	emake -f Makefile.linux || die "vldp build failed"
	cd "${S}/src/vldp2"
	egamesconf || die
	emake -f Makefile.linux || die "vldp2 build failed"
}

src_install() {
	dogamesbin daphne || die "dogamesbin failed"
	exeinto "${GAMES_LIBDIR}/${PN}"
	doexe libvldp*.so || die "doexe failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp -rf pics sound roms "${D}/${GAMES_DATADIR}/${PN}/" \
		|| die "cp failed"
	dodoc doc/*.{ini,txt}
	dohtml -r doc/*
	prepgamesdirs
}
