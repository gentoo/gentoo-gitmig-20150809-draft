# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom <ryan@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/elvis/elvis-2.1.4.ebuild,v 1.1 2001/05/15 01:49:44 ryan Exp $

A=elvis-2.1_4.tar.gz
S=${WORKDIR}/elvis-2.1_4
DESCRIPTION="A vi/ex clone"
SRC_URI="ftp://ftp.cs.pdx.edu/pub/elvis/${A}"
HOMEPAGE="ftp://ftp.cs.pdx.edu/pub/elvis/"

DEPEND="virtual/glibc
        >=sys-libs/ncurses-5.2
	X? ( virtual/x11 )"

src_compile() {

    local myconf
    if [ "`use X`" ]; then
	mconf="--with-x"
    else
	mconf="--without-x"
    fi
    try ./configure --bindir=${D}/usr/bin --datadir=${D}/usr/share/elvis ${myconf}
    cp Makefile Makefile.orig
    cat Makefile.orig | sed -e "s:gcc -O2:gcc ${CFLAGS}:" > Makefile
    try make

}

src_install () {

    cp instman.sh instman.sh.orig
    cat instman.sh.orig | sed -e "s:/usr/man:${D}/usr/share/man:g" > instman.sh
    cp insticon.sh insticon.sh.orig
    cat insticon.sh.orig | sed -e "s:^xinc=.*$:xinc=${D}/usr/include:" \
	| sed -e "s:^xlib=.*$:xlib=${D}/usr/lib:" > insticon.sh
    dodir /usr/bin
    dodir /usr/share/man/man1
    try make install

}
