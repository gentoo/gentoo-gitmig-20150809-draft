# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pbg1854@garnet.acns.fsu.edu>
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdparanoia/cdparanoia-3.9.7.ebuild,v 1.1 2001/02/05 02:23:36 achim Exp $

A=cdparanoia-III-alpha9.7.src.tgz
S=${WORKDIR}/cdparanoia-III-alpha9.7
DESCRIPTION="an advanced CDDA reader with error correction"
SRC_URI="http://www.xiph.org/paranoia/download/cdparanoia-III-alpha9.7.src.tgz"
HOMEPAGE="http://www.xiph.org/paranoia/index.html"


src_compile() {
    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make
}

src_install () {
    cd ${S}
    dodir /usr/bin /usr/lib /usr/man/man1 /usr/include
    try make prefix=${D}/usr install
    dodoc FAQ.txt GPL README
}
