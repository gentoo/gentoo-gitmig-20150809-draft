# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/kde-apps/kdbg/kdbg-1.2.1.ebuild,v 1.2 2001/06/07 01:45:52 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Graphical Debugger Interface to gdb"
SRC_URI="ftp://ftp.eudaptics.com/pub/people/jsixt/${A}"
HOMEPAGE="http://members.nextra.at/johsixt/kdbg.html"

DEPEND=">=kde-base/kdelibs-2.0.1"

src_compile() {
    local myconf
    if [ "`use qtmt`" ]
    then
      myconf="--enable-mt"
    fi
    if [ "`use mitshm`" ]
    then
      myconf="$myconf --enable-mitshm"
    fi
    try ./configure --prefix=${KDEDIR} --with-kde-version=2 --host=${CHOST} $myconf
    try make

}

src_install () {

    try make DESTDIR=${D} install

    dodoc BUGS COPYING ChangeLog README TODO 

}

