# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom <ryan@gentoo.org> 
# /home/cvsroot/gentoo-x86/app-misc/xtrlock/xtrlock-2.0.ebuild,v 1.1 2001/10/06 15:30:15 ryan Exp

A=xtrlock_2.0-6.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A simplistic screen locking program for X"
SRC_URI="ftp://ftp.debian.org/debian/dists/stable/main/source/x11/${A}"
HOMEPAGE="ftp://ftp.debian.org/debian/dists/stable/main/source/x11/"

DEPEND="virtual/x11"

src_compile() {

    xmkmf || die
    cp Makefile Makefile.orig
    make CFLAGS="${CFLAGS} -DSHADOW_PWD" xtrlock || die

}

src_install () {

    dobin xtrlock
    chmod u+s ${D}/usr/bin/xtrlock 
    mv xtrlock.man xtrlock.1
    doman xtrlock.1

}
