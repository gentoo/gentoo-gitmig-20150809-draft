# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/fceultra/fceultra-0.93.ebuild,v 1.2 2004/02/20 06:26:47 mr_bones_ Exp $

inherit games gcc

DESCRIPTION="A portable NES/Famicom emulator"
HOMEPAGE="http://fceultra.sourceforge.net/"
SRC_URI="http://fceultra.sourceforge.net/files/fceu${PV}src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"
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

S=${WORKDIR}/fceu

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i \
		-e "s:\${TFLAGS}:\${TFLAGS} ${CFLAGS}:" \
		Makefile.base
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
