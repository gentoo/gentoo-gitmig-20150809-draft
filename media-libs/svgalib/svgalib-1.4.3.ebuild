# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pete@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/svgalib/svgalib-1.4.3.ebuild,v 1.1 2001/06/28 18:31:19 ryan Exp $

#P=
A=${PN}-${PV}.tar.gz
S=${WORKDIR}/${PN}-${PV}
DESCRIPTION="a library for running svga graphics on the console"
SRC_URI="http://www.svgalib.org/${A}"
HOMEPAGE="http://www.svgalib.org/"

DEPEND="virtual/glibc"

src_unpack() {
    unpack ${A}
    cd ${S}
    patch -p1 < ${FILESDIR}/${PN}-${PV}-gentoo.diff
}

src_compile() {

    try make OPTIMIZE=\""${CFLAGS}"\" static
    try make OPTIMIZE=\""${CFLAGS}"\" shared
    try make OPTIMIZE=\""${CFLAGS}"\" textutils
    try make OPTIMIZE=\""${CFLAGS}"\" lrmi
    try make OPTIMIZE=\""${CFLAGS}"\" utils
    # Build the gl stuff tpp
    try make OPTIMIZE=\""${CFLAGS}"\" -C gl
    try make OPTIMIZE=\""${CFLAGS}"\" -C gl libvgagl.so.${PV}
}

src_install () {

    dodir /etc/svga /usr/{include,lib,bin,share/man}
    try make TOPDIR=${D} OPTIMIZE=\""${CFLAGS}"\" install
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
