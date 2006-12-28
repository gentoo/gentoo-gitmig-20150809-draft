# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/daphne/daphne-0.99.7.ebuild,v 1.1 2006/12/28 00:13:14 nyhm Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="Laserdisc Arcade Game Emulator"
HOMEPAGE="http://www.daphne-emu.com/"
SRC_URI="http://www.daphne-emu.com/download/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="media-libs/libogg
	media-libs/libvorbis
	media-libs/libsdl
	media-libs/sdl-mixer"

S=${WORKDIR}/${PN}/src

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${P}-gcc41.patch \
		"${FILESDIR}"/${P}-exec-stack.patch
	sed -i "/m_appdir =/s:\.:${GAMES_DATADIR}/${PN}:" \
		io/homedir.cpp \
		|| die "sed homedir.cpp failed"
	sed -i "s:pics/:${GAMES_DATADIR}/${PN}/&:" \
		video/video.cpp \
		|| die "sed video.cpp failed"
	sed -i "s:sound/:${GAMES_DATADIR}/${PN}/&:" \
		sound/sound.cpp \
		|| die "sed sound.cpp failed"
	sed -i "s:./lib:${GAMES_LIBDIR}/${PN}/lib:" \
		io/dll.h \
		|| die "sed dll.h failed"
	cp Makefile.vars{.linux_x86,}
}

src_compile() {
	emake \
		CXX=$(tc-getCXX) \
		DFLAGS="${CXXFLAGS}" \
		|| die "src build failed"
	cd vldp2
	egamesconf || die
	emake \
		-f Makefile.linux \
		CC=$(tc-getCC) \
		DFLAGS="${CFLAGS}" \
		|| die "vldp2 build failed"
}

src_install() {
	cd ..
	dogamesbin daphne || die "dogamesbin failed"
	exeinto "${GAMES_LIBDIR}"/${PN}
	doexe libvldp2.so || die "doexe failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r pics roms sound || die "doins failed"
	dodoc doc/*.{ini,txt}
	dohtml -r doc/*
	prepgamesdirs
}
