# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/xmess/xmess-0.83.1.ebuild,v 1.8 2006/12/01 22:04:28 wolf31o2 Exp $

inherit flag-o-matic toolchain-funcs eutils games

TARGET="${PN}"

DESCRIPTION="Multiple Arcade Machine Emulator for X11"
HOMEPAGE="http://x.mame.net/"
SRC_URI="http://x.mame.net/download/xmame-${PV}.tar.bz2"

LICENSE="xmame"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64"
IUSE="sdl dga xv alsa esd opengl X 3dfx svga ggi arts joystick net expat lirc xinerama"

RDEPEND="sys-libs/zlib
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	dga? (
		x11-libs/libXxf86dga
		x11-libs/libXxf86vm )
	esd? ( >=media-sound/esound-0.2.29 )
	expat? ( dev-libs/expat )
	ggi? ( media-libs/libggi )
	lirc? ( app-misc/lirc )
	opengl? (
		virtual/opengl
		virtual/glu )
	sdl? ( >=media-libs/libsdl-1.2.0 )
	svga? ( media-libs/svgalib )
	xinerama? ( x11-libs/libXinerama )
	xv? ( x11-libs/libXv )
	X? ( x11-libs/libXext )"
DEPEND="${RDEPEND}
	dga? (
		x11-proto/xf86dgaproto
		x11-proto/xf86vidmodeproto )
	xinerama? ( x11-proto/xineramaproto )
	xv? ( x11-proto/videoproto )
	x86? ( dev-lang/nasm )"
# Icc sucks. bug #41342
#	icc? ( dev-lang/icc )

S="${WORKDIR}/xmame-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${PV}-glx-fix.patch"
	sed -i \
		-e 's:JOY_BUTTONS 16:JOY_BUTTONS 32:' src/unix/devices.h \
			|| die "setting joybuttons failed" #36818

	case "${ARCH}" in
	x86)
		sed -i \
			-e '/X86_ASM_68000 =/s:#::' \
			-e '/X86_MIPS3_DRC =/s:#::' Makefile \
			|| die "sed Makefile (x86) failed"
		if  use joystick ; then
			sed -i \
				-e '/JOY_I386.*=/s:#::' Makefile \
				|| die "sed Makefile (joystick) failed"
		fi
		;;
	ia64)
		sed -i \
			-e '/^MY_CPU/s:i386:ia64:' Makefile \
			|| die "sed Makefile (ia64) failed"
		if  use joystick ; then
			sed -i \
				-e '/JOY_I386.*=/s:#::' Makefile \
				|| die "sed Makefile (joystick) failed"
		fi
		;;
	amd64)
		sed -i \
			-e '/^MY_CPU/s:i386:amd64:' Makefile \
			|| die "sed Makefile (amd64) failed"
		if  use joystick ; then
			sed -i \
				-e '/JOY_I386.*=/s:#::' Makefile \
				|| die "sed Makefile (joystick) failed"
		fi
		;;
	ppc|sparc|hppa)
		sed -i \
			-e '/^MY_CPU/s:i386:risc:' Makefile \
			|| die "sed Makefile (ppc|sparc|hppa) failed"
		;;
	alpha)
		sed -i \
			-e '/^MY_CPU/s:i386:alpha:' Makefile \
			|| die "sed Makefile (alpha) failed"
		;;
	mips)
		sed -i \
			-e '/^MY_CPU/s:i386:mips:' Makefile \
			|| die "sed Makefile (mips) failed"
		;;
	esac

	if use net ; then
		sed -i \
			-e '/XMAME_NET/s:#::' Makefile \
			|| die "sed Makefile (net) failed"
	fi
	if use esd ; then
		sed -i \
			-e '/SOUND_ESOUND/s:#::' Makefile \
			|| die "sed Makefile (esd) failed"
	fi
	if use alsa ; then
		sed -i \
			-e '/SOUND_ALSA/s:#::' Makefile \
			|| die "sed Makefile (alsa) failed"
	fi
	if use arts ; then
		sed -i \
			-e '/SOUND_ARTS/s:#::' Makefile \
			|| die "sed Makefile (arts) failed"
	fi
	if use sdl ; then
		sed -i \
			-e '/SOUND_SDL/s:#::' Makefile \
			|| die "sed Makefile (sdl) failed"
	fi
	if use dga ; then
		sed -i \
			-e '/X11_DGA/s:#::' Makefile \
			|| die "sed Makefile (dga) failed"
		if use 3dfx ; then
			sed -i \
				-e '/TDFX_DGA_WORKAROUND/s:#::' Makefile \
				|| die "sed Makefile (dga) failed"
		fi
	fi

	if use xv ; then
		sed -i \
			-e '/X11_XV/s:#::' Makefile \
			|| die "sed Makefile (xv) failed"
	fi

	case ${ARCH} in
		x86|ia64)	append-flags -Wno-unused -fomit-frame-pointer -fstrict-aliasing -fstrength-reduce -ffast-math
			[ $(gcc-major-version) -eq 3 ] \
				&& append-flags -falign-functions=2 -falign-jumps=2 -falign-loops=2 \
				|| append-flags -malign-functions=2 -malign-jumps=2 -malign-loops=2
			;;
		# amd64 no likey the -ffast-math - bug #54270
		amd64)	append-flags -Wno-unused -fomit-frame-pointer -fstrict-aliasing -fstrength-reduce
			;;
		ppc)	append-flags -Wno-unused -funroll-loops -fstrength-reduce -fomit-frame-pointer -ffast-math -fsigned-char
			;;
		hppa)	append-flags -ffunction-sections
			;;
	esac

	sed -i \
		-e "/^PREFIX/s:=.*:=/usr:" \
		-e "/^BINDIR/s:=.*:=${GAMES_BINDIR}:" \
		-e "/^MANDIR/s:=.*:=/usr/share/man/man6:" \
		-e "/^XMAMEROOT/s:=.*:=${GAMES_DATADIR}/${TARGET}:" \
		-e "/^TARGET/s:mame:${TARGET:1}:" \
		-e "s:^CFLAGS =:CFLAGS=${CFLAGS}:" Makefile \
		|| die "sed Makefile failed"
}

src_compile() {
	local disp=0
	if use sdl ; then
		emake DISPLAY_METHOD=SDL || die "emake failed (SDL)"
		disp=1
	fi
	if use svga ; then
		emake DISPLAY_METHOD=svgalib || die "emake failed (svgalib)"
		disp=1
	fi
	if use ggi ; then
		emake DISPLAY_METHOD=ggi || die "emake failed (ggi)"
		disp=1
	fi
	if use opengl ; then
		emake DISPLAY_METHOD=xgl || die "emake failed (xgl)"
		disp=1
	fi
	if  [ ${disp} -eq 0 ] || use X || use dga || use xv ; then
		emake DISPLAY_METHOD=x11 || die "emake failed (x11)"
	fi
}

src_install() {
	local disp=0

	sed -i \
		-e "s:Xmame:${TARGET}:g" \
		-e "s:xmame:${TARGET}:g" doc/*.6 \
		|| die "sed man pages failed"
	sed -i \
		-e "s:^PREFIX.*:PREFIX=${D}/usr:" \
		-e "s:^BINDIR.*:BINDIR=${D}/${GAMES_BINDIR}:" \
		-e "s:^MANDIR.*:MANDIR=${D}/usr/share/man/man6:" \
		-e "s:^XMAMEROOT.*:XMAMEROOT=${D}/${GAMES_DATADIR}/${TARGET}:" \
			Makefile \
			|| die "sed Makefile failed"

	if use sdl ; then
		make DISPLAY_METHOD=SDL install || die "install failed (sdl)"
		disp=1
	fi
	if use svga ; then
		make DISPLAY_METHOD=svgalib install || die "install failed (svga)"
		disp=1
	fi
	if use ggi ; then
		make DISPLAY_METHOD=ggi install || die "install failed (ggi)"
		disp=1
	fi
	if use opengl ; then
		make DISPLAY_METHOD=xgl install || die "install failed (xgl)"
		disp=1
	fi
	if [ ${disp} -eq 0 ] || use X || use dga || use xv ; then
		make DISPLAY_METHOD=x11 install || die "install failed (x11)"
	fi

	dodir "${GAMES_DATADIR}/${PN}"
	cp -r ctrlr "${D}/${GAMES_DATADIR}/${PN}/" || die "cp failed"
	dodoc doc/{changes.*,*.txt,mame/*,${TARGET}rc.dist} README todo \
		|| die "dodoc failed"
	dohtml -r doc/* || die "dohtml failed"

	if use opengl ; then
		dosym "${TARGET}.xgl" "${GAMES_BINDIR}/${TARGET}"
	elif [ ${disp} -eq 0 ] || use X || use dga || use xv ; then
		dosym "${TARGET}.x11" "${GAMES_BINDIR}/${TARGET}"
	elif use sdl ; then
		dosym "${TARGET}.SDL" "${GAMES_BINDIR}/${TARGET}"
	elif use svga ; then
		dosym ${TARGET}.svgalib ${GAMES_BINDIR}/${TARGET}
	elif use ggi ; then
		dosym ${TARGET}.ggi ${GAMES_BINDIR}/${TARGET}
	fi
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "Your available MAME binaries are: ${TARGET}"
	if use X || use dga || use xv ; then
		einfo " ${TARGET}.x11"
	fi
	use sdl > /dev/null                 && einfo " ${TARGET}.SDL"
	use ggi > /dev/null                 && einfo " ${TARGET}.ggi"
	use svga > /dev/null                && einfo " ${TARGET}.svgalib"
	use opengl > /dev/null              && einfo " ${TARGET}.xgl"
}
