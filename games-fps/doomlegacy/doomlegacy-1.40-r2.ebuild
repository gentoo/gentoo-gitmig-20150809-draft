# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doomlegacy/doomlegacy-1.40-r2.ebuild,v 1.1 2003/09/09 18:10:14 vapier Exp $

inherit games eutils

DESCRIPTION="Doom legacy, THE doom port"
HOMEPAGE="http://legacy.newdoom.com/"
SRC_URI="mirror://sourceforge/doomlegacy/legacy_${PV/./}_src.tar.gz
	mirror://sourceforge/doomlegacy/legacy.dat.gz
	http://www.lbjhs.net/~jessh/lsdldoom/doom1.wad.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="x86? ( >=dev-lang/nasm-0.98 )
	>=sys-apps/sed-4
	virtual/opengl
	virtual/x11"

S="${WORKDIR}/${PN}_src/"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-errno.patch

	# fix locations where objects/binaries get installed
	mkdir {.,${S}}/{bin,objs}
	cd ${S}
	epatch ${FILESDIR}/makefile.patch

	# if using the non-xfree version of GL header files, we need to patch ...
	[ -z "`grep XFree86 /usr/X11R6/include/GL/glx.h`" ] && \
		epatch ${FILESDIR}/CARD8.patch

	# disable logfile writing
	sed -i \
		-e 's:#define LOGMESSAGES::' doomdef.h || \
			die 'sed doomdef.h failed'

	# make sure the games can find the wads/data files
	sed -i \
		-e "s:#define DEFAULTWADLOCATION1:#define DEFAULTWADLOCATION1 \"${GAMES_DATADIR}/${PN}\" //:" \
		linux_x/i_system.c || \
			die 'sed linux_x/i_system.c failed'

	# move opengl lib file because it's not useful to anyone else
	sed -i \
		-e "s:\"r_opengl:\"${GAMES_LIBDIR}/${PN}/r_opengl:" \
		linux_x/i_video_xshm.c

	cd linux_x/musserv
	make -f Makefile.linux clean
}

src_compile() {
	# this is ugly but it's late (here) and it works
	local useasm=
	[ `use x86` ] && useasm="USEASM=1"
	local redosnd=0
	make \
		EXTRAOPTS="${CFLAGS}" \
		LINUX=1 \
		X=1 \
		${useasm} \
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
			|| die "build failed"
}

src_install() {
	dogamesbin linux_x/musserv/linux/musserver linux_x/sndserv/linux/llsndserv bin/llxdoom
	exeinto ${GAMES_LIBDIR}/${PN}
	doexe bin/r_opengl.so

	insinto ${GAMES_DATADIR}/${PN}
	doins ${WORKDIR}/{legacy.dat,doom1.wad}

	dohtml _doc/*.html
	rm _doc/*.html
	dodoc _doc/*
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	ewarn "Software support is broken with latest XFree versions."
	ewarn "If doomlegacy crashes with 'BadColor (invalid Colormap parameter)',"
	ewarn "then please start the game with the '-opengl' parameter."
	ewarn "See bug #19290 for more information."
}
