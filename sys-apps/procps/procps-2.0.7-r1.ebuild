# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/procps/procps-2.0.7-r1.ebuild,v 1.5 2000/12/08 17:21:49 achim Exp $

P=procps-2.0.7
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard informational utilities and process-handling tools"
SRC_URI="ftp://people.redhat.com/johnsonm/procps/${A}"
DEPEND=">=sys-libs/gpm-1.13.9"
RDEPEND="$DEPEND
	 >=sys-apps/bash-2.04"

src_compile() {                           
	try make ${MAKEOPTS}
}

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

src_install() {                               
    into /usr
    dodir /usr/bin
    dodir /sbin
    dodir /usr/X11R6/bin
    dodir /usr/man/man1
    dodir /usr/man/man8
    dodir /usr/man/man5
    dodir /lib
    dodir /bin
    try make DESTDIR=${D} install
    preplib /
    dodoc BUGS COPYING COPYING.LIB NEWS TODO
    docinto proc
    dodoc proc/COPYING
    docinto ps
    dodoc ps/COPYING ps/HACKING
}



