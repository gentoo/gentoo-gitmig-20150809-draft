# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/fceultra/fceultra-0.81-r1.ebuild,v 1.10 2006/04/13 20:32:39 wolf31o2 Exp $

inherit toolchain-funcs games

MY_P=fceu
S=${WORKDIR}/${MY_P}
DESCRIPTION="A portable NES/Famicom Emulator"
HOMEPAGE="http://fceultra.sourceforge.net/"
SRC_URI="http://fceultra.sourceforge.net/dev/${MY_P}${PV//.}src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc"
IUSE="sdl svga"

DEPEND="svga? ( media-libs/svgalib )
	sdl? ( media-libs/libsdl )"

pkg_setup() {
	games_pkg_setup
	if [ `gcc-major-version` == 3 ] && [ `gcc-minor-version` == 2 ] && [ ${ARCH} == "x86" ] ; then
		eerror "Do not use gcc 3.2.x to compile the source code"
		eerror "on 80x86/IA32 platforms. It has a code generation"
		eerror "bug in it that will cause FCE Ultra to not work."
		die "cant compile on x86 with gcc-3.2.x"
	fi

	use sdl && return 0
	use svga && return 0

	eerror "You must have 'sdl' or 'svga' in your USE variable"
	die "unable to build SVGA or SDL versions"
}

src_compile() {
	mv Makefile.base Makefile.orig
	sed -e "s:\${TFLAGS}:\${TFLAGS} ${CFLAGS}:" \
		Makefile.orig > Makefile.base

	if use sdl ; then
		make -f Makefile.unixsdl || die "sdl make failed"
		mv fceu fceu-sdl
		make -f Makefile.unixsdl clean
	fi
	if use svga ; then
		make -f Makefile.linuxvga || die "svga make failed"
		mv fceu fceu-svga
	fi
}

src_install() {
	use sdl && dobin fceu-sdl
	use svga && dobin fceu-svga
	dodoc Documentation/{*,rel/readme-linux.txt}
	prepgamesdirs
}
