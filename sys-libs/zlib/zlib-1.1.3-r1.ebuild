# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/zlib/zlib-1.1.3-r1.ebuild,v 1.5 2000/11/07 11:16:08 achim Exp $

P=zlib-1.1.3
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard (de)compression library"
SRC_URI="ftp://ftp.freesoftware.com/pub/infozip/zlib/${A}"

DEPEND=">=sys-libs/glibc-2.1.3"
RDEPEND=$DEPEND

src_compile() {            
   cd ${S}               
    try ./configure --shared --prefix=/usr
    try make
    try make test
    try ./configure --prefix=/usr
    try make
}

src_install() {                               
    into /usr
    dodir /usr/include
    insinto /usr/include
    doins zconf.h zlib.h
    dolib libz.so.1.1.3
    dolib libz.a
#    dosym libz.so.1.1.3 /usr/lib/libz.so
#    dosym libz.so.1.1.3 /usr/lib/libz.so.1
    preplib
    dodoc FAQ README algorithm.txt ChangeLog
}

