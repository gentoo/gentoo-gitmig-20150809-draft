# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/zlib/zlib-1.1.3-r2.ebuild,v 1.1 2001/02/07 16:10:52 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard (de)compression library"
SRC_URI="ftp://ftp.freesoftware.com/pub/infozip/zlib/${A}"

DEPEND="virtual/glibc"

src_compile() {            

    try ./configure --shared --prefix=/usr
    try make ${MAKEOPTS}
    try make test
    try ./configure --prefix=/usr
    try make ${MAKEOPTS}
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

    doman zlib.3
    dodoc FAQ README ChangeLog
    docinto txt
    dodoc algorithm.txt
}

