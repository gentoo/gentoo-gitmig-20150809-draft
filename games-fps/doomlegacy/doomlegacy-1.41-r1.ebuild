# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doomlegacy/doomlegacy-1.41-r1.ebuild,v 1.2 2003/12/29 05:32:36 vapier Exp $

inherit games eutils

DESCRIPTION="Doom legacy, THE doom port"
HOMEPAGE="http://legacy.newdoom.com/"
SRC_URI="mirror://sourceforge/doomlegacy/legacy_${PV/./}_src.tar.gz
	mirror://gentoo/legacy-${PV}.dat.bz2
	http://www.lbjhs.net/~jessh/lsdldoom/doom1.wad.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="sdl"

DEPEND="x86? ( >=dev-lang/nasm-0.98 )
	>=sys-apps/sed-4
	virtual/opengl
	virtual/x11
	sdl? ( media-libs/libsdl media-libs/sdl-mixer )"

S=${WORKDIR}/legacy_${PV//.}_src

src_unpack() {
	unpack ${A}
	mkdir bin
	cd ${S}
	epatch ${FILESDIR}/${PV}-errno.patch
	epatch ${FILESDIR}/${PV}-makefile.patch

	# disable logfile writing
	sed -i 's:#define LOGMESSAGES::' doomdef.h || die 'sed doomdef.h failed'

	# make sure the games can find the wads/data files
	sed -i \
		"/#define DEFAULTWADLOCATION1/s:\".*\":\"${GAMES_DATADIR}/${PN}\":" \
		linux_x/i_system.c

	# move opengl lib file because it's not useful to anyone else
	sed -i "s:\"r_opengl:\"${GAMES_LIBDIR}/${PN}/r_opengl:" linux_x/i_video_xshm.c

	cd linux_x/musserv
	make -f Makefile.linux clean
}

src_compile() {
	# this is ugly but it's late (here) and it works
	local useasm=
	[ `use x86` ] && useasm="USEASM=1"
	local usesdl=
	[ `use sdl` ] && usesdl="SDL=1"
	local redosnd=0
	make \
		EXTRAOPTS="${CFLAGS}" \
		LINUX=1 \
		X=1 \
		${useasm} \
		${usesdl} \
		|| redosnd=1
	if [ ${redosnd} -eq 1 ] ; then
		cd linux_x/sndserv
		make clean || die "clean snd srv failed"
		make EXTRAOPTS="${CFLAGS}" || die "snd serv failed"
	fi
	cd ${S}
	make \
		EXTRAOPTS="${CFLAGS}" \
		LINUX=1 \
		X=1 \
		${useasm} \
		${usesdl} \
		|| die "build failed"
}

src_install() {
	dogamesbin \
		linux_x/musserv/linux/musserver \
		linux_x/sndserv/linux/llsndserv \
		${WORKDIR}/bin/llxdoom
	use sdl && dogamesbin ${WORKDIR}/bin/lsdldoom
	exeinto ${GAMES_LIBDIR}/${PN}
	doexe ${WORKDIR}/bin/r_opengl.so

	insinto ${GAMES_DATADIR}/${PN}
	doins ${WORKDIR}/doom1.wad
	newins ${WORKDIR}/legacy-${PV}.dat legacy.dat

	dohtml _doc/*.html
	rm _doc/*.html
	dodoc _doc/*
	prepgamesdirs
}
