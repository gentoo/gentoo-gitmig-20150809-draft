# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/kde-apps/kdbg/kdbg-1.2.0.ebuild,v 1.1 2001/02/08 15:57:29 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Graphical Debugger Interface to gdb"
SRC_URI="ftp://ftp.eudaptics.com/pub/people/jsixt/${A}"
HOMEPAGE="http://members.nextra.at/johsixt/kdbg.html"

DEPEND=">=kde-base/kdelibs-2.0.1"

src_compile() {

    cd ${S}
    try ./configure --prefix=/opt/kde2 --with-kde-version=2 --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install

    dodoc BUGS COPYING ChangeLog README TODO 

}

