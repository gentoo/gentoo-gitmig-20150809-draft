# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/svgalib/svgalib-1.4.3-r1.ebuild,v 1.3 2002/07/23 00:49:50 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a library for running svga graphics on the console"
SRC_URI="http://www.svgalib.org/${P}.tar.gz"
HOMEPAGE="http://www.svgalib.org/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 -ppc -sparc -sparc64"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {

	make OPTIMIZE="${CFLAGS}" static shared textutils lrmi utils || die
	# Build the gl stuff tpp
	make OPTIMIZE="${CFLAGS}" -C gl || die
	make OPTIMIZE="${CFLAGS}" -C gl libvgagl.so.${PV} || die

	cp Makefile Makefile.orig
	sed 's/\(install: $(INSTALLAOUTLIB) \)installheaders \(.*\)/\1\2/g' \
	 	Makefile.orig > Makefile
}

src_install () {

	dodir /etc/{vga,svga} /usr/{include,lib,bin,share/man}
	make TOPDIR=${D} OPTIMIZE="${CFLAGS}" install || die
	insinto /usr/include
	doins gl/vgagl.h
	dolib.a gl/libvgagl.a
	dolib.so gl/libvgagl.so.${PV}
	dosym libvgagl.so.${PV} /usr/lib/libvgagl.so

	insinto /usr/include
	doins src/vga.h gl/vgagl.h src/mouse/vgamouse.h src/joystick/vgajoystick.h
	doins src/keyboard/vgakeyboard.h

	cd doc
	dodoc 0-README CHANGES* DESIGN NEWS TODO
	docinto txt
	dodoc  Driver-programming-HOWTO README.* add_driver svgalib.lsm

}
