# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/slang/slang-1.4.2.ebuild,v 1.4 2000/11/30 23:14:00 achim Exp $

P=slang-1.4.2
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Console display library used by most text viewer"
SRC_URI="ftp://space.mit.edu/pub/davis/slang/v1.4/${A}"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {                           
    try ./configure --host=${CHOST} --prefix=/usr
    try make ${MAKEOPTS} prefix=${D}/usr elf
}

src_unpack() {
    unpack ${A}
    cd ${S}
    cp configure configure.orig
    sed -e "s/ELF_CFLAGS=\"-O2/ELF_CFLAGS=\"${CFLAGS}/" configure.orig > configure
}

src_install() {    
    try make ${MAKEOPTS} prefix=${D}/usr install-elf   
    preplib /usr
    rm -rf ${D}/usr/doc/slang                      
    dodoc COPYING* NEWS README *.txt
    dodoc doc/*.txt doc/internal/*.txt doc/text/*.txt
    docinto html
    dodoc doc/*.html
}



