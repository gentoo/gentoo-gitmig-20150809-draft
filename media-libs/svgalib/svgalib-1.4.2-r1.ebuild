# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pete@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/svgalib/svgalib-1.4.2-r1.ebuild,v 1.3 2002/04/27 11:47:44 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a library for running svga graphics on the console"
SRC_URI="http://www.svgalib.org/${P}.tar.gz"
HOMEPAGE="http://www.svgalib.org/"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${PN}-${PV}-gentoo.diff
}

src_compile() {

	 make OPTIMIZE="${CFLAGS}" static || die
	 make OPTIMIZE="${CFLAGS}" shared || die
	 make OPTIMIZE="${CFLAGS}" textutils || die
	 make OPTIMIZE="${CFLAGS}" lrmi || die
	 make OPTIMIZE="${CFLAGS}" utils || die
	# Build the gl stuff tpp
	 make OPTIMIZE="${CFLAGS}" -C gl || die
	 make OPTIMIZE="${CFLAGS}" -C gl libvgagl.so.${PV} || die
}

src_install () {

	dodir /etc/svga /usr/{include,lib,bin,share/man}
	make TOPDIR=${D} OPTIMIZE="${CFLAGS}" install || die
	insinto /usr/include
	doins gl/vgagl.h
	dolib.a gl/libvgagl.a
	dolib.so gl/libvgagl.so.${PV}
	dosym libvgagl.so.${PV} /usr/lib/libvgagl.so

	cd doc
	dodoc 0-README CHANGES* DESIGN NEWS TODO
	docinto txt
	dodoc  Driver-programming-HOWTO README.* add_driver svgalib.lsm

}
