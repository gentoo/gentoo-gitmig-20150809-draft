# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xmame/xmame-0.60.1-r4.ebuild,v 1.3 2003/02/13 07:19:07 vapier Exp $

DESCRIPTION="Multiple Arcade Machine Emulator for X11"
SRC_URI="http://x.mame.net/download/${P}.tar.bz2
		http://x.mame.net/download/0.60.1-0.61.1-pr1.diff.bz2
		http://x.mame.net/download/0.61.1-pr1-0.61.1-pr2.diff.bz2
		http://x.mame.net/download/0.61.1-pr2-0.61.1-pr3.diff.bz2
		http://x.mame.net/download/0.61.1-pr3-0.61.1-pr4.diff.bz2
		http://x.mame.net/download/0.61.1-pr4-0.61.1-pr5.diff.bz2
		http://x.mame.net/download/0.61.1-pr5-0.61.1-pr6.diff.bz2
		http://x.mame.net/download/0.61.1-pr6-0.61.1-pr7.diff.bz2
		http://x.mame.net/download/0.61.1-pr7-0.61.1-pr8.diff.bz2"
HOMEPAGE="http://x.mame.net/"

SLOT="0"
LICENSE="xmame"
KEYWORDS="x86 ppc"
IUSE="sdl dga xv alsa esd opengl X 3dfx"

DEPEND="xv? ( virtual/x11 )
	dga? ( virtual/x11 )
	sdl? ( >=media-libs/libsdl-1.2.0 )
	>=sys-libs/zlib-1.1.3-r2
	alsa? ( media-libs/alsa-lib )
	xv? ( >=x11-base/xfree-4.1.0 )
	dga? ( >=x11-base/xfree-4.1.0 )
	esd? ( >=media-sound/esound-0.2.29 )"

RDEPEND=${DEPEND}

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}
	bzcat ${DISTDIR}/0.60.1-0.61.1-pr1.diff.bz2 | patch -p1
	bzcat ${DISTDIR}/0.61.1-pr1-0.61.1-pr2.diff.bz2 | patch -p1
	bzcat ${DISTDIR}/0.61.1-pr2-0.61.1-pr3.diff.bz2 | patch -p1
	bzcat ${DISTDIR}/0.61.1-pr3-0.61.1-pr4.diff.bz2 | patch -p1
	bzcat ${DISTDIR}/0.61.1-pr4-0.61.1-pr5.diff.bz2 | patch -p1
	bzcat ${DISTDIR}/0.61.1-pr5-0.61.1-pr6.diff.bz2 | patch -p1
	bzcat ${DISTDIR}/0.61.1-pr6-0.61.1-pr7.diff.bz2 | patch -p1
	bzcat ${DISTDIR}/0.61.1-pr7-0.61.1-pr8.diff.bz2 | patch -p1

	sed -e "s:CFLAGS    = -O -Wall:\#CFLAGS=:g" -e \
	"s:PREFIX = /usr/local:PREFIX = /usr:g" -e \
	"s:MANDIR = \$\(PREFIX\)/man/man6:MANDIR = \$\(PREFIX\)/share/man/man6:g" \
	makefile.unix > makefile.unix.tmp
	mv makefile.unix.tmp makefile.unix

	if [ ${ARCH} = "x86" ]
	then
		# Enable joystick support
		sed -e "s/\# JOY_I386/JOY_I386/g" makefile.unix > makefile.unix.tmp
		mv makefile.unix.tmp makefile.unix
	fi

	if [ ${ARCH} = "ppc" ]
	then
		sed -e "s:MY_CPU = i386:\#MY_CPU = i386:g" -e \
		"s:\# MY_CPU = risc$:MY_CPU = risc:" makefile.unix > makefile.unix.tmp
	        mv makefile.unix.tmp makefile.unix
	fi

	if [ "`use esd`" ]; then
		sed -e "s/\# SOUND_ESOUND/SOUND_ESOUND/g" makefile.unix > makefile.unix.tmp
		mv makefile.unix.tmp makefile.unix
	fi

	if [ "`use alsa`" ]; then
		sed -e "s/\# SOUND_ALSA/SOUND_ALSA/g" makefile.unix > makefile.unix.tmp
		mv makefile.unix.tmp makefile.unix
	fi

	if [ "`use X`" ] || [ "`use dga`" ] || [ "`use xv`" ]; then
		cp makefile.unix makefile.x11;
	fi

	if [ "`use sdl`" ]; then
		cp makefile.unix makefile.SDL
		sed -e "s/DISPLAY_METHOD = x11/DISPLAY_METHOD = SDL/g" \
		makefile.SDL > makefile.SDL.tmp
		mv makefile.SDL.tmp makefile.SDL
	fi

	if [ "`use dga`" ]; then
		sed -e "s/\# X11_DGA = 1/X11_DGA = 1/g" \
		makefile.x11 > makefile.x11.tmp
		mv makefile.x11.tmp makefile.x11
		if [ "`use 3dfx`"]; then
			sed -e "s/\# TDFX_DGA_WORKAROUND/TDFX_DGA_WORKAROUND/g" \
			makefile.x11 > makefile.x11.tmp
			mv makefile.x11.tmp makefile.x11
		fi
		if [ "`use sdl`" ]; then
			sed -e "s/\# X11_DGA = 1/X11_DGA = 1/g" \
			makefile.SDL > makefile.SDL.tmp
			mv makefile.SDL.tmp makefile.SDL
			if [ "`use 3dfx`"]; then
				sed -e "s/\# TDFX_DGA_WORKAROUND/TDFX_DGA_WORKAROUND/g" \
				makefile.SDL > makefile.SDL.tmp
				mv makefile.SDL.tmp makefile.SDL
			fi
		fi
	fi

#	Caleb Shay 08 Oct 2002
#	xmame.xgl is currently broken
#	if [ "`use opengl`"; then
#		cp makefile.x11 makefile.xgl
#		sed -e "s:DISPLAY_METHOD = x11:DISPLAY_METHOD = xgl:g" \
#			makefile.xgl > makefile.xgl.tmp
#		mv makefile.xgl.tmp makefile.xgl
#	fi

	if [ "`use xv`" ]; then
		sed -e "s/\# X11_XV = 1/X11_XV = 1/g" makefile.x11 > makefile.x11.tmp
		mv makefile.x11.tmp  makefile.x11
	fi
}

src_compile() {
	local MYFLAGS
	MYFLAGS=""
	# 08 Oct 2002 Caleb Shay
	# Parallel makes breaks the build
	MAKEOPTS=""

	if [ ${ARCH} = "ppc" ] ; then
		# add Makefile suggested flags for ppc
		MYFLAGS="${CFLAGS} -funroll-loops \
		-fstrength-reduce -fomit-frame-pointer -ffast-math -fsigned-char"
	fi
	if [ ${ARCH} = "x86" ] ; then
		# add Makefile suggested flags for x86
		MYFLAGS="${CFLAGS} -O3 -Wall -Wno-unused -funroll-loops \
		-fstrength-reduce -fomit-frame-pointer -ffast-math -falign-functions=2 \
		-falign-jumps=2 -falign-loops=2"
	fi

		# rphillips 23 Jul 2002
		# compile doesn't work on x86 platforms with -O3 optimizations
		# Caleb Shay 08 Oct 2002
		# No longer true
		# MYFLAGS=`echo $MYFLAGS | sed 's/-O3/-O2/'`
	if [ "`use X`" ] || [ "`use dga`" ] || [ "`use xv`" ]; then
		cp makefile.x11 Makefile
		emake CFLAGS="${MYFLAGS}" || die
	fi
	if [ "`use sdl`" ]; then
		cp makefile.SDL Makefile
		emake CFLAGS="${MYFLAGS}" || die
	fi
}

src_install() {
	if [ "`use X`" ] || [ "`use dga`" ] || [ "`use xv`" ]; then
		cp makefile.x11 Makefile
		make \
			PREFIX=${D}/usr \
			MANDIR=${D}/usr/share/man/man6 \
			install
	fi
	if [ "`use sdl`" ]; then
		cp makefile.SDL Makefile
		make \
			PREFIX=${D}/usr \
			MANDIR=${D}/usr/share/man/man6 \
			install
	fi

	dodoc doc/{changes.*,dga2.txt,gamelist.mame,readme.mame,xmamerc.dist}
	dodoc doc/{xmame-doc.ps,xmame-doc.txt}

	dohtml -r doc

	if [ "`use sdl`" ]; then
		dosym xmame.SDL /usr/bin/xmame
	else
		dosym xmame.x11 /usr/bin/xmame
	fi
}

pkg_postinst() {
	if [ "`use sdl`" ]; then
		einfo "xmame is a symbolic link to xmame.SDL"
		if [ "`use X`" ] || [ "`use dga`" ] || [ "`use xv`" ]; then
			einfo "If you wish to use x11 (non-SDL) mame, use xmame.x11"
		fi
	else
		einfo "xmame is a symbolic link to xmame.x11"
	fi
}
