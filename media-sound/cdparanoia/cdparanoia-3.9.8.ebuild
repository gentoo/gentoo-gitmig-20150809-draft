# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pbg1854@garnet.acns.fsu.edu>
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdparanoia/cdparanoia-3.9.8.ebuild,v 1.2 2001/05/28 05:24:13 achim Exp $

A=${PN}-III-alpha9.8.src.tgz
S=${WORKDIR}/${PN}-III-alpha9.8
DESCRIPTION="an advanced CDDA reader with error correction"
SRC_URI="http://www.xiph.org/paranoia/download/${A}"
HOMEPAGE="http://www.xiph.org/paranoia/index.html"

DEPEND="virtual/glibc"

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}
    try make OPT=\"$CFLAGS\"
}

src_install () {
    cd ${S}
    dodir /usr/bin /usr/lib /usr/share/man1 /usr/include
    try make prefix=${D}/usr MANDIR=${D}/usr/share/man install
    dodoc FAQ.txt GPL README
}
