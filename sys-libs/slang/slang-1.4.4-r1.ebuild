# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/slang/slang-1.4.4-r1.ebuild,v 1.2 2001/04/06 14:26:41 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Console display library used by most text viewer"
SRC_URI="ftp://space.mit.edu/pub/davis/slang/v1.4/${A}"

DEPEND=">=sys-libs/ncurses-5.2-r2"

src_unpack() {

    unpack ${A}
    cd ${S}
    cp configure configure.orig
    sed -e "s/ELF_CFLAGS=\"-O2/ELF_CFLAGS=\"${CFLAGS}/" configure.orig > configure
}


src_compile() {

    try ./configure --host=${CHOST} --prefix=/usr
    try make ${MAKEOPTS} prefix=${D}/usr all elf
    #cp src/objs/libslang.a .
    #try make ${MAKEOPTS} prefix=${D}/usr clean elf
}

src_install() {

    dolib.a  src/objs/libslang.a
    dolib.so src/elfobjs/libslang.so.${PV}
    dosym libslang.so.${PV} /usr/lib/libslang.so

    insinto /usr/include
    doins src/{slang.h,slcurses.h}
    dodoc COPYING* NEWS README *.txt
    dodoc doc/*.txt doc/internal/*.txt doc/text/*.txt
    docinto html
    dodoc doc/*.html
}



