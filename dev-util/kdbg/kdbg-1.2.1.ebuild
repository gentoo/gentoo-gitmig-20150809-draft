# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdbg/kdbg-1.2.1.ebuild,v 1.4 2001/11/10 12:45:09 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Graphical Debugger Interface to gdb"
SRC_URI="ftp://ftp.eudaptics.com/pub/people/jsixt/${P}.tar.gz"
HOMEPAGE="http://members.nextra.at/johsixt/kdbg.html"

DEPEND=">=kde-base/kdelibs-2.0.1"

src_compile() {
    local myconf
    if [ "`use qtmt`" ]
    then
      myconf="--enable-mt"
    fi
      myconf="$myconf --enable-mitshm"
    try ./configure --prefix=${KDEDIR} --with-kde-version=2 --host=${CHOST} $myconf
    try make

}

src_install () {

    try make DESTDIR=${D} install

    dodoc BUGS COPYING ChangeLog README TODO 

}

