# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/xmame/xmame-0.97.ebuild,v 1.2 2005/08/05 04:02:50 mr_bones_ Exp $

inherit flag-o-matic toolchain-funcs eutils games

TARGET="${PN}"

DESCRIPTION="Multiple Arcade Machine Emulator for X11"
HOMEPAGE="http://x.mame.net/"
SRC_URI="http://x.mame.net/download/xmame-${PV}.tar.bz2"

LICENSE="XMAME"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ppc ~sparc x86"
IUSE="alsa arts dga esd expat ggi joystick lirc mmx net opengl sdl svga X xv"

RDEPEND="sys-libs/zlib
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	dga? ( virtual/x11 )
	esd? ( >=media-sound/esound-0.2.29 )
	expat? ( dev-libs/expat )
	ggi? ( media-libs/libggi )
	lirc? ( app-misc/lirc )
	opengl? (
		virtual/x11
		virtual/opengl
		virtual/glu )
	sdl? ( >=media-libs/libsdl-1.2.0 )
	svga? ( media-libs/svgalib )
	X? ( virtual/x11 )
	xv? ( virtual/x11 )"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"
# Icc sucks. bug #41342
#	icc? ( dev-lang/icc )

S=${WORKDIR}/xmame-${PV}

toggle_feature() {
	if use $1 ; then
		sed -i \
			-e "/$2.*=/s:#::" Makefile \
			|| die "sed Makefile ($1 / $2) failed"
	fi
}

toggle_feature2() {
	use $1 && toggle_feature $2 $3
}

src_unpack() {
	local mycpu=

	unpack ${A}
	cd "${S}"

	case ${ARCH} in
		x86)	mycpu="i386";;
		ia64)	mycpu="ia64";;
		amd64)	mycpu="amd64";;
		ppc)	mycpu="risc";;
		sparc)	mycpu="risc";;
		hppa)	mycpu="risc";;
		alpha)	mycpu="alpha";;
		mips)	mycpu="mips";;
	esac

	sed -i \
		-e '/^BUILD_EXPAT/s/^/#/' \
		-e "/^PREFIX/s:=.*:=/usr:" \
		-e "/^MY_CPU/s:i386:${mycpu}:" \
		-e "/^BINDIR/s:=.*:=${GAMES_BINDIR}:" \
		-e "/^MANDIR/s:=.*:=/usr/share/man/man6:" \
		-e "/^XMAMEROOT/s:=.*:=${GAMES_DATADIR}/${TARGET}:" \
		-e "/^TARGET/s:mame:${TARGET:1}:" \
		-e "/^CFLAGS =/d" \
		Makefile \
		|| die "sed Makefile failed"

	if use ppc ; then
		sed -i \
			-e '/LD.*--relax/s:^# ::' Makefile \
			|| die "sed Makefile (ppc/LD) failed"
	fi


	toggle_feature x86 X86_MIPS3_DRC
	toggle_feature2 x86 mmx EFFECT_MMX_ASM
	toggle_feature joystick JOY_STANDARD
	toggle_feature2 joystick X XINPUT_DEVICES
	use net && ewarn "Network support is currently (${PV}) broken :("
	#toggle_feature net XMAME_NET # Broken
	toggle_feature esd SOUND_ESOUND
	toggle_feature alsa SOUND_ALSA
	toggle_feature arts SOUND_ARTS
	toggle_feature dga X11_DGA
	toggle_feature xv X11_XV
	toggle_feature expat BUILD_EXPAT
	toggle_feature opengl X11_OPENGL
	toggle_feature lirc LIRC

	case ${ARCH} in
		x86|ia64|amd64)
			append-flags -Wno-unused -fomit-frame-pointer -fstrict-aliasing -fstrength-reduce
			use amd64 || append-flags -ffast-math #54270
			[[ $(gcc-major-version) -eq 3 ]] \
				&& append-flags -falign-functions=2 -falign-jumps=2 -falign-loops=2 \
				|| append-flags -malign-functions=2 -malign-jumps=2 -malign-loops=2
			;;
		ppc)
			append-flags -Wno-unused -funroll-loops -fstrength-reduce -fomit-frame-pointer -ffast-math -fsigned-char
			;;
		hppa)
			append-flags -ffunction-sections
			;;
	esac

	sed -i \
		-e "s:[Xx]mame:${TARGET}:g" \
		doc/*.6 \
		|| die "sed man pages failed"
	# no, we don't want to install setuid (bug #81693)
	sed -i \
		-e 's/^doinstallsuid/notforus/' \
		-e 's/doinstallsuid/doinstall/' \
		-e '/^QUIET/s:^:#:' src/unix/unix.mak \
		|| die "sed src/unix/unix.mak failed"
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
		#emake DISPLAY_METHOD=ggi || die "emake failed (ggi)"
		#disp=1
		ewarn "GGI support is currently (${PV}) broken :("
	fi
	if  [ ${disp} -eq 0 ] || use opengl || use X || use dga || use xv ; then
		emake DISPLAY_METHOD=x11 || die "emake failed (x11)"
	fi
}

src_install() {
	local disp=0

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
		#make DISPLAY_METHOD=ggi install || die "install failed (ggi)"
		#disp=1
		ewarn "GGI support is currently (${PV}) broken :("
	fi
	if [ ${disp} -eq 0 ] || use opengl || use X || use dga || use xv ; then
		make DISPLAY_METHOD=x11 install || die "install failed (x11)"
	fi
	exeinto "${GAMES_LIBDIR}/${PN}"
	doexe chdman || die "doexe failed"
	if [[ ${PN} == "xmame" ]] ; then
		doexe xml2info || die "doexe failed"
	fi

	dodir "${GAMES_DATADIR}/${PN}"
	cp -r ctrlr "${D}/${GAMES_DATADIR}/${PN}/" || die "cp failed"
	dodoc doc/{changes.*,*.txt,mame/*,${TARGET}rc.dist} README todo \
		|| die "dodoc failed"
	dohtml -r doc/* || die "dohtml failed"

	# default to sdl since the client is a bit more featureful
	if use sdl ; then
		dosym "${TARGET}.SDL" "${GAMES_BINDIR}/${TARGET}"
	elif [ ${disp} -eq 0 ] || use opengl || use X || use dga || use xv ; then
		dosym "${TARGET}.x11" "${GAMES_BINDIR}/${TARGET}"
	elif use svga ; then
		dosym ${TARGET}.svgalib "${GAMES_BINDIR}/${TARGET}"
	#elif use ggi ; then
		#dosym ${TARGET}.ggi "${GAMES_BINDIR}/${TARGET}"
	fi
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "Your available MAME binaries are: ${TARGET}"
	if useq opengl || useq X || useq dga || useq xv ; then
		einfo " ${TARGET}.x11"
	fi
	useq sdl    && einfo " ${TARGET}.SDL"
	#useq ggi    && einfo " ${TARGET}.ggi"
	useq svga   && einfo " ${TARGET}.svgalib"
}
