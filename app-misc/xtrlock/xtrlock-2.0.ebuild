# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /home/cvsroot/gentoo-x86/app-misc/xtrlock/xtrlock-2.0.ebuild,v 1.1 2001/10/06 15:30:15 ryan Exp

MY_P=${PN}_${PV}-6
S=${WORKDIR}/${P}
DESCRIPTION="A simplistic screen locking program for X"
SRC_URI="ftp://ftp.debian.org/debian/dists/stable/main/source/x11/${MY_P}.tar.gz"
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
