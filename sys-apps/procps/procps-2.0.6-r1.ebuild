# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/procps/procps-2.0.6-r1.ebuild,v 1.1 2001/04/29 18:56:12 achim Exp $

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
    patch -p0 < ${FILESDIR}/${P}.dif

    mv Makefile Makefile.orig
    sed -e "s/-O3/${CFLAGS}/" -e 's/all: config/all: /' \
	-e "s:--strip::" Makefile.orig > Makefile

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
    try make DESTDIR=${D} MAN1DIR=/usr/share/man/man1 \
	MAN8DIR=/usr/share/man/man8 install

    preplib /
    dodoc BUGS COPYING COPYING.LIB NEWS TODO
    docinto proc
    dodoc proc/COPYING
    docinto ps
    dodoc ps/COPYING ps/HACKING
}



