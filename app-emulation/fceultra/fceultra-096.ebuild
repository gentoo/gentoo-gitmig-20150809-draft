# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/fceultra/fceultra-096.ebuild,v 1.1 2003/06/24 05:50:54 sunflare Exp $

inherit gcc

MY_P=fceu
S=${WORKDIR}/${MY_P}
DESCRIPTION="A portable NES/Famicom emulator"
SRC_URI="http://fceultra.sourceforge.net/dev/${MY_P}${PV}src.tar.gz"
HOMEPAGE="http://fceultra.sourceforge.net/"

SLOT="0"
KEYWORDS="~x86 -ppc"
LICENSE="GPL-2"

# Because of code generation bugs, FCEUltra now depends on a version
# of gcc greater than or equal to GCC 3.2.2.

DEPEND="svga? ( media-libs/svgalib )
	sdl? ( media-libs/libsdl )
	>=sys-devel/gcc-3.2.2"

RDEPEND=${DEPEND}

pkg_setup() {

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
