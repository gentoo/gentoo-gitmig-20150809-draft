# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/eject/eject-2.0.4.ebuild,v 1.1 2001/05/06 16:20:03 achim Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION=""
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/disk-management/${A}"
HOMEPAGE="http://www.pobox.com/~tranter/eject.html"

DEPEND="virtual/glibc"

src_compile() {
    try make CFLAGS=\""${CFLAGS}"\" 
}

src_install () {
    dodir /usr/bin /usr/share/man/man1
    try make DESTDIR=${D} BINDIR=/usr/bin MANDIR=/usr/share/man install
    dodoc ChangeLog COPYING README PORTING TODO
}
