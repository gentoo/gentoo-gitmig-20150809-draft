# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/zlib/zlib-1.1.3-r1.ebuild,v 1.1 2000/08/03 16:22:36 achim Exp $

P=zlib-1.1.3
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard (de)compression library"
CATEGORY="sys-libs"
SRC_URI="ftp://ftp.freesoftware.com/pub/infozip/zlib/${A}"

src_compile() {            
   cd ${S}               
    ./configure --shared --prefix=/usr
    make
    make test
    ./configure --prefix=/usr
    make
}

src_install() {                               
    into /usr
    dodir /usr/include
    insinto /usr/include
    doins zconf.h zlib.h
    dolib libz.so.1.1.3
    dolib libz.a
    dosym libz.so.1.1.3 /usr/lib/libz.so
    dosym libz.so.1.1.3 /usr/lib/libz.so.1
    dodoc FAQ README algorithm.txt ChangeLog
}

