# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/fceultra/fceultra-0.81-r1.ebuild,v 1.3 2004/02/20 06:26:47 mr_bones_ Exp $

inherit gcc

MY_P=fceu
S=${WORKDIR}/${MY_P}
DESCRIPTION="A portable NES/Famicom Emulator"
HOMEPAGE="http://fceultra.sourceforge.net/"
SRC_URI="http://fceultra.sourceforge.net/dev/${MY_P}${PV//.}src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc"

DEPEND="svga? ( media-libs/svgalib )
	sdl? ( media-libs/libsdl )"

pkg_setup() {
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

	if [ `use sdl` ] ; then
		make -f Makefile.unixsdl || die "sdl make failed"
		mv fceu fceu-sdl
		make -f Makefile.unixsdl clean
	fi
	if [ `use svga` ] ; then
		make -f Makefile.linuxvga || die "svga make failed"
		mv fceu fceu-svga
	fi
}

src_install() {
	use sdl && dobin fceu-sdl
	use svga && dobin fceu-svga
	dodoc Documentation/{*,rel/readme-linux.txt}
}
