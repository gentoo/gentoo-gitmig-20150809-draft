# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pete@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/svgalib/svgalib-1.4.2.ebuild,v 1.2 2001/02/11 21:12:48 pete Exp $

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
    cd ${S}
    try make OPTIMIZE=\""${CFLAGS}"\" static
    try make OPTIMIZE=\""${CFLAGS}"\" shared
    try make OPTIMIZE=\""${CFLAGS}"\" textutils
    try make OPTIMIZE=\""${CFLAGS}"\" lrmi
    try make OPTIMIZE=\""${CFLAGS}"\" utils
}

src_install () {
    cd ${S}
    dodir /etc/svga
    dodir /usr/include
    dodir /usr/lib
    dodir /usr/bin
    dodir /usr/share/man
    try make TOPDIR=${D} OPTIMIZE=\""${CFLAGS}"\" install
    
    cd ${S}
    dodoc 0-INSTALL 0-README LICENSE svgalib.lsm
    cd ${S}/doc
    docinto doc
    dodoc 0-README CHANGES CHANGES.mach64 DESIGN Driver-programming-HOWTO NEWS
    dodoc README.joystick README.kernel-2.3 README.keymap README.patching
    dodoc README.vesa TODO add_driver svgalib.lsm
}
