# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/slang/slang-1.4.2.ebuild,v 1.2 2000/09/15 20:09:29 drobbins Exp $

P=slang-1.4.2
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Console display library used by most text viewer"
SRC_URI="ftp://space.mit.edu/pub/davis/slang/v1.4/${A}"

src_compile() {                           
    try ./configure --host=${CHOST} --prefix=/usr
    try make elf
}

src_unpack() {
    unpack ${A}
    cd ${S}
    cp configure configure.orig
    sed -e "s/ELF_CFLAGS=\"-O2/ELF_CFLAGS=\"${CFLAGS}/" configure.orig > configure
}

src_install() {                               
    into /usr
    libopts -m0755
    dolib src/elfobjs/libslang.so.1.4.2
    dosym libslang.so.1.4.2 /usr/lib/libslang.so.1
    dosym libslang.so.1 /usr/lib/libslang.so
    dodoc COPYING* NEWS README *.txt
    dodoc doc/*.txt doc/internal/*.txt doc/text/*.txt
    docinto html
    dodoc doc/*.html
    dodir /usr/include
    insinto /usr/include
    cd ${S}/src
    doins slang.h slcurses.h
}



