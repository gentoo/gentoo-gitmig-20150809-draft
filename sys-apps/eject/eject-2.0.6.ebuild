# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/eject/eject-2.0.6.ebuild,v 1.1 2001/05/14 10:48:12 achim Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION=""
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/disk-management/${A}"
HOMEPAGE="http://www.pobox.com/~tranter/eject.html"

DEPEND="virtual/glibc"

src_compile() {
    try ./configure --prefix=/usr --mandir=/usr/share/man
    try make 
}

src_install () {
    dodir /usr/bin /usr/share/man/man1
    try make DESTDIR=${D} install
    dodoc ChangeLog COPYING README PORTING TODO 
    dodoc AUTHORS NEWS PROBLEMS
}
