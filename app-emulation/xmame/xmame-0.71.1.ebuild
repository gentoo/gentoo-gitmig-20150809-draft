# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xmame/xmame-0.71.1.ebuild,v 1.1 2003/08/16 06:06:12 vapier Exp $

inherit games flag-o-matic gcc eutils

TARGET=${PN}

DESCRIPTION="Multiple Arcade Machine Emulator for X11"
SRC_URI="http://x.mame.net/download/xmame-${PV}.tar.bz2"
HOMEPAGE="http://x.mame.net/"

LICENSE="xmame"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~mips ~alpha"
IUSE="sdl dga xv alsa esd opengl X 3dfx svga ggi arts joystick"

DEPEND="sys-libs/zlib
	sdl? ( >=media-libs/libsdl-1.2.0 )
	alsa? ( media-libs/alsa-lib )
	xv? ( >=x11-base/xfree-4.1.0 )
	dga? ( >=x11-base/xfree-4.1.0 )
	esd? ( >=media-sound/esound-0.2.29 )
	svga? ( media-libs/svgalib )
	ggi? ( media-libs/libggi )
	arts? ( kde-base/arts )
	x86? ( dev-lang/nasm )"

S=${WORKDIR}/xmame-${PV}

src_unpack() {
	unpack ${A}

	cd ${S}

	epatch ${FILESDIR}/${PV}-glx-fix.patch
	epatch ${FILESDIR}/${PV}-mips-fix.patch

	[ ${ARCH} == "x86" ] && sed -i -e '/X86_ASM_68000 =/s:#::' -e '/X86_MIPS3_DRC =/s:#::' Makefile
	[ ${ARCH} == "ppc" ] && sed -i '/^MY_CPU/s:i386:risc:' Makefile
	[ ${ARCH} == "sparc" ] && sed -i '/^MY_CPU/s:i386:risc:' Makefile
	[ ${ARCH} == "alpha" ] && sed -i '/^MY_CPU/s:i386:alpha:' Makefile
	[ ${ARCH} == "mips" ] && sed -i '/^MY_CPU/s:i386:mips:' Makefile

	[ ${ARCH} == "x86" ] && [ `use joystick` ] && sed -i '/JOY_I386.*=/s:#::' Makefile

	[ `use esd` ] && sed -i '/SOUND_ESOUND/s:#::' Makefile
	[ `use alsa` ] && sed -i '/SOUND_ALSA/s:#::' Makefile
	[ `use arts` ] && sed -i '/SOUND_ARTS/s:#::' Makefile
	[ `use sdl` ] && sed -i '/SOUND_SDL/s:#::' Makefile

	if [ `use dga` ] ; then
		sed -i '/X11_DGA/s:#::' Makefile
		[ `use 3dfx` ] && sed -i '/TDFX_DGA_WORKAROUND/s:#::' Makefile
	fi

	[ `use xv` ] && sed -i '/X11_XV/s:#::' Makefile

	sed -i \
		-e "/^PREFIX/s:=.*:=/usr:" \
		-e "/^BINDIR/s:=.*:=${GAMES_BINDIR}:" \
		-e "/^XMAMEROOT/s:=.*:=${GAMES_DATADIR}/${TARGET}:" \
		-e "/^TARGET/s:mame:${TARGET:1}:" \
		Makefile

	case ${ARCH} in
		x86)	append-flags -Wno-unused -fomit-frame-pointer -fstrict-aliasing -fstrength-reduce -ffast-math
			[ `gcc-major-version` -eq 3 ] \
				&& append-flags -falign-functions=2 -falign-jumps=2 -falign-loops=2 \
				|| append-flags -malign-functions=2 -malign-jumps=2 -malign-loops=2
			;;
		ppc)	append-flags -Wno-unused -funroll-loops -fstrength-reduce -fomit-frame-pointer -ffast-math -fsigned-char
			;;
	esac
	sed -i "s:^CFLAGS =:CFLAGS=${CFLAGS}:" Makefile
}

src_compile() {
	[ ! -z "`use X``use dga``use xv`" ] && { make DISPLAY_METHOD=x11 || die; }
	[ `use sdl` ] && { make DISPLAY_METHOD=SDL || die; }
	[ `use svga` ] && { make DISPLAY_METHOD=svgalib || die; }
	[ `use ggi` ] && { make DISPLAY_METHOD=ggi || die; }
	[ `use opengl` ] && { make DISPLAY_METHOD=xgl || die; }
}

src_install() {
	sed -i \
		-e "s:^PREFIX.*:PREFIX=${D}/usr:" \
		-e "s:^BINDIR.*:BINDIR=${D}/${GAMES_BINDIR}:" \
		-e "s:^XMAMEROOT.*:XMAMEROOT=${D}/${GAMES_DATADIR}/${TARGET}:" \
		Makefile

	[ ! -z "`use X``use dga``use xv`" ]	&& { make DISPLAY_METHOD=x11 install || die; }
	[ `use sdl` ]				&& { make DISPLAY_METHOD=SDL install || die; }
	[ `use svga` ]				&& { make DISPLAY_METHOD=svgalib install || die; }
	[ `use ggi` ]				&& { make DISPLAY_METHOD=ggi install || die; }
	[ `use opengl` ]			&& { make DISPLAY_METHOD=xgl install || die; }

	dodoc doc/{changes.*,*.txt,mame/*,${TARGET}rc.dist} README todo
	dohtml -r doc/*

	if [ `use opengl` ] ; then
		dosym ${TARGET}.xgl ${GAMES_BINDIR}/${TARGET}
	elif [ ! -z "`use X``use dga``use xv`" ] ; then
		dosym ${TARGET}.x11 ${GAMES_BINDIR}/${TARGET}
	elif [ `use sdl` ] ; then
		dosym ${TARGET}.SDL ${GAMES_BINDIR}/${TARGET}
	elif [ `use svga` ] ; then
		dosym ${TARGET}.svgalib ${GAMES_BINDIR}/${TARGET}
	elif [ `use ggi` ] ; then
		dosym ${TARGET}.ggi ${GAMES_BINDIR}/${TARGET}
	fi

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "Your available MAME binaries are:"
	[ ! -z "`use X``use dga``use xv`" ] && einfo " ${TARGET}.x11"
	[ `use sdl` ] && einfo " ${TARGET}.SDL"
	[ `use svga` ] && einfo " ${TARGET}.svgalib"
	[ `use ggi` ] && einfo " ${TARGET}.ggi"
	[ `use opengl` ] && einfo " ${TARGET}.xgl"
}
