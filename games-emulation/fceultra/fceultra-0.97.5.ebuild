# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/fceultra/fceultra-0.97.5.ebuild,v 1.3 2004/01/18 05:07:43 vapier Exp $

inherit games gcc eutils

DESCRIPTION="A portable NES/Famicom emulator"
HOMEPAGE="http://fceultra.sourceforge.net/"
SRC_URI="http://xodnizel.net/fceultra/downloads/fceu-${PV}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"

IUSE="sdl svga"

# Because of code generation bugs, FCEUltra now depends on a version
# of gcc greater than or equal to GCC 3.2.2.
RDEPEND="|| (
		svga? ( media-libs/svgalib )
		sdl? ( media-libs/libsdl )
		media-libs/libsdl
	)
	>=sys-devel/gcc-3.2.2
	sys-libs/zlib"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/fceu

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch "${FILESDIR}/${PV}-joystick.patch"
	sed -i \
		-e 's:-mcpu=i686 -O2::' \
		-e 's:-fomit-frame-pointer::' \
		Makefile.linuxvga Makefile.unixsdl Makefile.unixsdl.gtk || \
			die "sed Makefiles failed"
	sed -i \
		-e "s:\${TFLAGS}:\${TFLAGS} ${CFLAGS}:" Makefile.base || \
			die "sed Makefile.base failed"
}

src_compile() {
	if [ `use sdl` ] || [ -z "`use sdl``use svga`" ] ; then
		emake -f Makefile.unixsdl || die "sdl make failed"
		mv fceu fceu-sdl
		make -f Makefile.unixsdl clean
	fi
	if [ `use svga` ] ; then
		emake -f Makefile.linuxvga || die "svga make failed"
		mv fceu fceu-svga
	fi
}

src_install() {
	if [ `use sdl` ] || [ -z "`use sdl``use svga`" ] ; then
		dogamesbin fceu-sdl     || die "dogamesbin failed (sdl)"
		doman Documentation/*.6 || die "doman failed (sdl)"
	fi
	if use svga ; then
		dogamesbin fceu-svga    || die "dogamesbin failed (svga)"
		doman Documentation/*.6 || die "doman failed (svga)"
	fi
	dodoc Documentation/{*.txt,AUTHORS,FAQ,README,TODO} || die "dodoc failed"
	cp -r Documentation/tech "${D}/usr/share/doc/${P}/" || die "cp failed"
	find ${D}/usr/share/doc/${P}/tech -type f -exec gzip -9 \{\} \; || \
		die "find failed"
	dohtml Documentation/*                              || die "dohtml failed"
	prepgamesdirs
}
