# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/procps/procps-2.0.7-r2.ebuild,v 1.2 2001/02/07 20:42:54 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard informational utilities and process-handling tools"
SRC_URI="ftp://people.redhat.com/johnsonm/procps/${A}"
DEPEND=">=sys-libs/ncurses-5.2-r2
        sys-libs/getext"
DEPEND=">=sys-libs/ncurses-5.2-r2"

src_unpack() {

    unpack ${A}

    cd ${S}

    mv Makefile Makefile.orig
    sed -e "s/-O3/${CFLAGS}/" -e 's/all: config/all: /' \
	-e "s:--strip::" Makefile.orig > Makefile

    mv watch.c watch.c.orig
    sed -e "s/<ncurses.h>/<NEW>/" -e "s/<signal.h>/<ncurses.h>/" -e "s/<NEW>/<signal.h>/" watch.c.orig >watch.c

    cd ${S}/ps
    mv Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/" -e "s:--strip::" Makefile.orig > Makefile

    cd ${S}/proc
    mv Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/" -e "s:--strip::"  Makefile.orig > Makefile

}

src_compile() {
	try make ${MAKEOPTS}
}

src_install() {

    dodir /usr/bin
    dodir /sbin
    dodir /usr/X11R6/bin
    dodir /usr/share/man/man{1,5,8}
    dodir /lib
    dodir /bin
    try make DESTDIR=${D} MANDIR=/usr/share/man install

    preplib /
    dodoc BUGS COPYING COPYING.LIB NEWS TODO
    docinto proc
    dodoc proc/COPYING
    docinto ps
    dodoc ps/COPYING ps/HACKING
}



