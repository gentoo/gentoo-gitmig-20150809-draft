# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Based on the 0.59.1 ebuild by Ben Lutgens <blutgens@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xmame/xmame-0.62.2-r1.ebuild,v 1.4 2003/04/28 01:51:30 vapier Exp $

IUSE="sdl dga xv alsa esd opengl X 3dfx svga ggi arts"

P="xmame-0.62.2"
S=${WORKDIR}/${P}
DESCRIPTION="Multiple Arcade Machine Emulator for X11"
SRC_URI="http://x.mame.net/download/${P}.tar.bz2"
HOMEPAGE="http://x.mame.net"
SLOT="0"
LICENSE="xmame"
DEPEND="sdl? ( >=media-libs/libsdl-1.2.0 )
	sys-libs/zlib
	alsa? ( media-libs/alsa-lib )
	xv? ( >=x11-base/xfree-4.1.0 )
	dga? ( >=x11-base/xfree-4.1.0 )
	esd? ( >=media-sound/esound-0.2.29 )
	svga? ( media-libs/svgalib )
	ggi? ( media-libs/libggi )
	arts? ( kde-base/arts )"

RDEPEND=${DEPEND}

if [ ${ARCH} = "x86" ]; then
	DEPEND="${DEPEND} ( dev-lang/nasm )"
fi



# Please note modifications for ppc in this ebuild.  If you update the ebuild,
# please either test on ppc, or send it to a ppc developer for testing before
# you commit the ebuild.  Thanks :-)

KEYWORDS="x86 ppc"

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}
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
		# Enable M68K asm core
		sed -e "s/\# X86_ASM_68000 = 1/X86_ASM_68000 = 1/g" makefile.unix > makefile.unix.tmp
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

	if [ "`use arts`" ]; then
		sed -e "s/\# SOUND_ARTS/SOUND_ARTS/g" makefile.unix > makefile.unix.tmp
		mv makefile.unix.tmp makefile.unix
	fi

	if [ "`use X`" ] || [ "`use dga`" ] || [ "`use xv`" ]; then
		cp makefile.unix makefile.x11;
	fi

	if [ "`use svga`" ]; then
		cp makefile.unix makefile.svga
		sed -e "s/DISPLAY_METHOD = x11/DISPLAY_METHOD = svgalib/g" \
		makefile.svga > makefile.svga.tmp
		mv makefile.svga.tmp makefile.svga
	fi

	if [ "`use sdl`" ]; then
		cp makefile.unix makefile.SDL
		sed -e "s/DISPLAY_METHOD = x11/DISPLAY_METHOD = SDL/g" \
		makefile.SDL > makefile.SDL.tmp
		mv makefile.SDL.tmp makefile.SDL
	fi

	if [ "`use ggi`" ]; then
		cp makefile.unix makefile.ggi
		sed -e "s/DISPLAY_METHOD = x11/DISPLAY_METHOD = ggi/g" \
		makefile.ggi > makefile.ggi.tmp
		mv makefile.ggi.tmp makefile.ggi
	fi

	if [ "`use opengl`" ]; then
		cp makefile.unix makefile.xgl
		sed -e "s/DISPLAY_METHOD = x11/DISPLAY_METHOD = xgl/g" \
		makefile.xgl > makefile.xgl.tmp
		mv makefile.xgl.tmp makefile.xgl
		sed -e "s/<GL\/glx.h>/\"\/usr\/lib\/opengl\/xfree\/include\/glx.h\"/g" \
		src/unix/video-drivers/gltool.h > src/unix/video-drivers/gltool.h.tmp
		mv src/unix/video-drivers/gltool.h.tmp src/unix/video-drivers/gltool.h
	fi
	
	if [ "`use dga`" ]; then
		sed -e "s/\# X11_DGA = 1/X11_DGA = 1/g" \
		makefile.x11 > makefile.x11.tmp
		mv makefile.x11.tmp makefile.x11
		if [ "`use 3dfx`" ]; then
			sed -e "s/\# TDFX_DGA_WORKAROUND/TDFX_DGA_WORKAROUND/g" \
			makefile.x11 > makefile.x11.tmp
			mv makefile.x11.tmp makefile.x11
		fi
		if [ "`use sdl`" ]; then
			sed -e "s/\# X11_DGA = 1/X11_DGA = 1/g" \
			makefile.SDL > makefile.SDL.tmp
			mv makefile.SDL.tmp makefile.SDL
			if [ "`use 3dfx`" ]; then
				sed -e "s/\# TDFX_DGA_WORKAROUND/TDFX_DGA_WORKAROUND/g" \
				makefile.SDL > makefile.SDL.tmp
				mv makefile.SDL.tmp makefile.SDL
			fi
		fi
	fi

	if [ "`use xv`" ]; then
		sed -e "s/\# X11_XV = 1/X11_XV = 1/g" makefile.x11 > makefile.x11.tmp
		mv makefile.x11.tmp  makefile.x11
	fi
}

src_compile() {
	local MYFLAGS
	local GCCMAJ
	MYFLAGS=""
	# 08 Oct 2002 Caleb Shay
	# Parallel makes breaks the build
	MAKEOPTS=""

	GCCMAJ=`gcc -v 2>&1 | grep version | awk '{print $3}' | cut -f1 -d\.`

	if [ ${ARCH} = "ppc" ] ; then
		# add Makefile suggested flags for ppc
		MYFLAGS="${CFLAGS} -funroll-loops \
		-fstrength-reduce -fomit-frame-pointer -ffast-math -fsigned-char"
	fi

	if [ ${ARCH} = "x86" ] ; then
		# add Makefile suggested flags for x86
		MYFLAGS="${CFLAGS} -O3 -Wall -Wno-unused -funroll-loops \
		-fstrength-reduce -fomit-frame-pointer -ffast-math"
		if [ ${GCCMAJ} = "2" ]; then
			MYFLAGS="${MYFLAGS} -malign-functions=2 -malign-jumps=2 -malign-loops=2"
		else
			MYFLAGS="${MYFLAGS} -falign-functions=2 -falign-jumps=2 -falign-loops=2"
		fi
	fi

	if [ "`use X`" ] || [ "`use dga`" ] || [ "`use xv`" ]; then
		cp makefile.x11 Makefile
		emake CFLAGS="${MYFLAGS}" || die
	fi

	if [ "`use sdl`" ]; then
		cp makefile.SDL Makefile
		emake CFLAGS="${MYFLAGS}" || die
	fi

	if [ "`use svga`" ]; then
		cp makefile.svga Makefile
		emake CFLAGS="${MYFLAGS}" || die
	fi

	if [ "`use ggi`" ]; then
		cp makefile.ggi Makefile
		emake CFLAGS="${MYFLAGS}" || die
	fi
	
	if [ "`use opengl`" ]; then
		cp makefile.xgl Makefile
		emake CFLAGS="${MYFLAGS}" || die
	fi
}

src_install () {

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
	if [ "`use svga`" ]; then
		cp makefile.svga Makefile
		make \
			PREFIX=${D}/usr \
			MANDIR=${D}/usr/share/man/man6 \
			install
	fi
	if [ "`use ggi`" ]; then
		cp makefile.ggi Makefile
		make \
			PREFIX=${D}/usr \
			MANDIR=${D}/usr/share/man/man6 \
			install
	fi

	if [ "`use opengl`" ]; then
		cp makefile.xgl Makefile
		make \
			PREFIX=${D}/usr \
			MANDIR=${D}/usr/share/man/man6 \
			install
	fi

	dodoc doc/{changes.*,dga2.txt,gamelist.mame,readme.mame,xmamerc.dist}
	dodoc doc/{xmame-doc.ps,xmame-doc.txt}

	dohtml -r doc

	if [ "`use X`" ] || [ "`use dga`" ] || [ "`use xv`" ]; then
		dosym xmame.x11 /usr/bin/xmame
	fi

}

pkg_postinst() {

	einfo "Your available MAME binaries are:"
	if [ "`use X`" ] || [ "`use dga`" ] || [ "`use xv`" ]; then
		einfo "	xmame.x11";
	fi
	if [ "`use sdl`" ]; then
		einfo "	xmame.SDL"
	fi
	if [ "`use svga`" ]; then
		einfo "	xmame.svgalib"
	fi
	if [ "`use ggi`" ]; then
		einfo "	xmame.ggi"
	fi
	if [ "`use opengl`" ]; then
		einfo "	xmame.xgl"
	fi
	if [ "`use X`" ] || [ "`use dga`" ] || [ "`use xv`" ]; then
		einfo "xmame is a symbolic link to xmame.x11"
	fi

}
