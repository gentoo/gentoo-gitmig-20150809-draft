# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/fceultra/fceultra-096.ebuild,v 1.2 2003/06/28 06:05:21 vapier Exp $

inherit games gcc

MY_PN=fceu
DESCRIPTION="A portable NES/Famicom emulator"
SRC_URI="http://fceultra.sourceforge.net/files/${MY_PN}${PV}src.tar.gz"
HOMEPAGE="http://fceultra.sourceforge.net/"

SLOT="0"
KEYWORDS="x86 -ppc"
LICENSE="GPL-2"
IUSE="sdl svga"

# Because of code generation bugs, FCEUltra now depends on a version
# of gcc greater than or equal to GCC 3.2.2.
DEPEND="|| (
		svga? ( media-libs/svgalib )
		sdl? ( media-libs/libsdl )
		media-libs/libsdl
	)
	>=sys-devel/gcc-3.2.2
	sys-libs/zlib"

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}

	cp ${S}/Makefile.base{,.orig}
	sed -e "s:\${TFLAGS}:\${TFLAGS} ${CFLAGS}:" \
		${S}/Makefile.base.orig > ${S}/Makefile.base
}

src_compile() {
	if [ `use sdl` ] || [ -z "`use sdl``use svga`" ] ; then
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
	use sdl && dogamesbin fceu-sdl
	use svga && dogamesbin fceu-svga
	use sdl || use svga || dogamesbin fceu-sdl
	dodoc Documentation/{*,rel/readme-linux.txt}
	prepgamesdirs
}
