# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/psemu-peopssoftgpu/psemu-peopssoftgpu-1.6.ebuild,v 1.9 2003/02/13 07:16:05 vapier Exp $

IUSE="sdl"

DESCRIPTION="P.E.Op.S Software GPU plugin"
HOMEPAGE="http://peops.sourceforge.net"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc"
SLOT="0"
DEPEND="x11-libs/gtk+
	dev-lang/nasm
	sdl? ( media-libs/libsdl )"
SRC_URI="mirror://sourceforge/peops/PeopsSoftGpu106.tar.gz"
S=${WORKDIR}

lowercase() {
	for f in $*; do
		mv "$f" "$(echo $f | tr A-Z a-z)"
	done
}

src_compile() {
	cd src
	lowercase makes/mk.X11 Gpu.[ch] Stdafx.h Cfg.c Draw.c Key.c Menu.c \
	          Prim.c Soft.c
	sed 's:CFLAGS =:CFLAGS +=:g' <makes/plg.mk >makes/plg.mk.tmp
	mv -f makes/plg.mk.tmp makes/plg.mk

	emake || die "Failed to make X11-version"

	use sdl && (
		sed 's:mk.x11:mk.fpse:g' <Makefile >Makefile.sdl
		echo 'INCLUDE = `sdl-config --cflags`' >makes/mk.fpse.tmp
		sed 's:-lSDL:`sdl-config --libs`:g' <makes/mk.fpse >>makes/mk.fpse.tmp
		mv -f makes/mk.fpse.tmp makes/mk.fpse
		make clean
		emake -f Makefile.sdl || die "Failed to make SDL-version"
	)
}

src_install () {
	insinto /usr/lib/psemu/plugins/
	doins src/libgpu*
	dodoc readme_1_6.txt version_1_6.txt
}

