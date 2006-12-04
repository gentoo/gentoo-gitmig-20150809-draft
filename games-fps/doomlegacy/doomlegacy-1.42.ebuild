# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doomlegacy/doomlegacy-1.42.ebuild,v 1.5 2006/12/04 23:03:00 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Doom legacy, THE doom port"
HOMEPAGE="http://legacy.newdoom.com/"
SRC_URI="mirror://sourceforge/doomlegacy/legacy_${PV/.}_src.tar.gz
	mirror://gentoo/legacy-${PV}.dat.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-ppc x86"
IUSE="X dga esd" #sdl - broken with recent sdl-mixer releases

RDEPEND="
	virtual/opengl
	virtual/glu
	x11-libs/libXxf86vm
	esd? ( media-sound/esound )"
	# broken with recent sdl-mixer releases
	#sdl? (
		#media-libs/libsdl
		#media-libs/sdl-mixer
	#)"
DEPEND="${RDEPEND}
	x86? ( >=dev-lang/nasm-0.98 )
	x11-proto/xextproto
    x11-proto/xf86vidmodeproto
	dga? ( x11-proto/xf86dgaproto )"

S=${WORKDIR}/doomlegacy_${PV/.}_src

src_unpack() {
	unpack ${A}
	mkdir bin
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-errno.patch
	epatch "${FILESDIR}"/${PV}-makefile.patch
	epatch "${FILESDIR}"/${PV}-sdl-gentoo-paths.patch

	# disable logfile writing
	sed -i \
		-e 's:#define LOGMESSAGES::' doomdef.h \
		|| die 'sed failed'

	# make sure the games can find the wads/data files
	sed -i \
		-e "/#define DEFAULTWADLOCATION1/s:\".*\":\"${GAMES_DATADIR}/doom-data\":" \
		linux_x/i_system.c || die "sed linux_x/i_system.c failed"
	sed -i \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/doom-data:" \
		sdl/i_system.c || die "sed failed"

	# move opengl lib file because it's not useful to anyone else
	sed -i \
		-e "s:\"r_opengl:\"${GAMES_LIBDIR}/${PN}/r_opengl:" \
		linux_x/i_video_xshm.c \
		|| die "sed failed"

	cd linux_x/musserv
	make -f Makefile.linux clean
}

src_compile() {
	# this is ugly but it's late (here) and it works
	local makeopts i interfaces

	# broken with recent sdl-mixer releases
	#use sdl && interfaces="${interfaces} SDL"
	use X && interfaces="${interfaces} X"
	[ -z "${interfaces}" ] && interfaces="X"
	mkdir "${WORKDIR}"/my-bins
	for i in ${interfaces} ; do
		case ${i} in
			SDL)
				makeopts="LINUX=1 SDL=1 HAVE_MIXER=1" ;;
			X)
				makeopts="LINUX=1 X=1"
				use x86 && makeopts="${makeopts} USEASM=1"
				use dga && makeopts="${makeopts} WITH_DGA=1"
				use esd && makeopts="${makeopts} HAVE_ESD=1";;
		esac
		emake EXTRAOPTS="${CFLAGS}" ${makeopts} || die "build failed"
		mv \
			"${WORKDIR}"/bin/* \
			linux_x/musserv/linux/musserver \
			linux_x/sndserv/linux/llsndserv \
			"${WORKDIR}"/my-bins/
		rm "${WORKDIR}"/objs/*
	done
}

src_install() {
	dohtml _doc/*.html
	rm _doc/*.html
	dodoc _doc/*

	cd "${WORKDIR}"
	exeinto "${GAMES_LIBDIR}/${PN}"
	doexe my-bins/r_opengl.so || die "doexe failed"
	rm my-bins/r_opengl.so
	dogamesbin my-bins/* || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}/doom-data"
	newins legacy-${PV}.dat legacy.dat || die "newins failed"

	prepgamesdirs
}
