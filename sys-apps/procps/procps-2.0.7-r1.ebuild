# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/procps/procps-2.0.7-r1.ebuild,v 1.1 2000/08/02 17:07:14 achim Exp $

P=procps-2.0.7
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard informational utilities and process-handling tools"
CATEGORY="sys-apps"
SRC_URI="ftp://people.redhat.com/johnsonm/procps/${A}"

src_compile() {                           
	make
        cd ps
        make
}

src_unpack() {
    unpack ${A}
    cd ${S}
    mv Makefile Makefile.orig
    sed -e "s/-O3/${CFLAGS}/" -e 's/all: config/all: /' Makefile.orig > Makefile
    mv watch.c watch.c.orig
    sed -e "s/<ncurses.h>/<NEW>/" -e "s/<signal.h>/<ncurses.h>/" -e "s/<NEW>/<signal.h>/" watch.c.orig >watch.c
    cd ${S}/ps
    mv Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/" Makefile.orig > Makefile
    cd ${S}/proc
    mv Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/" Makefile.orig > Makefile
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
    make DESTDIR=${D} install
    prepman
    cd ${S}
    dodoc BUGS COPYING COPYING.LIB NEWS TODO
  #  dobin ps/ps
}



