# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/psemu-peopssoftgpu/psemu-peopssoftgpu-1.14.ebuild,v 1.1 2003/07/13 07:09:51 vapier Exp $

DESCRIPTION="P.E.Op.S Software GPU plugin"
HOMEPAGE="http://sourceforge.net/projects/peops/"
SRC_URI="mirror://sourceforge/peops/PeopsSoftGpu${PV//.}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="sdl"

DEPEND="=x11-libs/gtk+-1*
	sdl? ( media-libs/libsdl )
	dev-lang/nasm"

S=${WORKDIR}

src_compile() {
	cd src
	sed -i -e 's:CFLAGS =:CFLAGS +=:' makes/plg.mk || die "cflag fix failed"

	emake || die "x11 build failed"

	if [ `use sdl` ] ; then
		sed -i 's:mk.x11:mk.fpse:g' Makefile
		sed -i \
			-e '/^INCLUDE =/s:$: `sdl-config --cflags`:' \
			-e 's:-lSDL:`sdl-config --cflags`:' \
			makes/mk.fpse
		make clean || die
		emake || die "sdl build failed"
	fi
}

src_install() {
	exeinto /usr/lib/psemu/plugins
	doexe src/libgpuPeops*.so* cfgPeopsSoft || die

	insinto /usr/lib/psemu/cfg
	doins gpuPeopsSoftX.cfg

	dodoc *.txt
}
