# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/bzip2/bzip2-1.0.1.ebuild,v 1.5 2000/09/21 22:32:56 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A high-quality data compressor used extensively by Gentoo"
SRC_URI="ftp://sourceware.cygnus.com/pub/bzip2/v100/$A"
HOMEPAGE="http://sourceware.cygnus.com/bzip2/"

src_unpack() {
    unpack ${A}
    # bzip2's try makefile does not use CFLAGS so we hard-wire the compile
    # options using sed ;)
    cd ${S}
    cp Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/" Makefile.orig > Makefile
    cp Makefile-libbz2_so Makefile-libbz2.orig
    sed -e "s/-O2/${CFLAGS}/" Makefile-libbz2.orig > Makefile-libbz2_so
}

src_compile() {                           
	try make -f Makefile-libbz2_so all
	try make all
}
src_install() {                               
	dodoc README LICENSE CHANGES manual.ps 
	docinto html
	dodoc manual_*.html
	try make PREFIX=${D}/usr install
	strip ${D}/usr/bin/*
        into /usr
	dolib.so libbz2.so.1.0.1
	dosym /usr/lib/libbz2.so.1.0.1 /usr/lib/libbz2.so.1.0
        prepman
}


