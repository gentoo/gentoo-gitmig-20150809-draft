# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author David Rufino <daverufino@btinternet.com>
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpg321/mpg321-0.1.5.ebuild,v 1.1 2001/09/18 23:00:47 woodchip Exp $

A=${PN}_${PV}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Free mp3 player"
SRC_URI="http://people.debian.org/~drew/${A}"
HOMEPAGE="http://people.debian.org/~drew/"

DEPEND="virtual/glibc
        >=media-sound/mad-0.13.0b
        >=media-libs/libao-0.8.0"

src_unpack () {
    unpack ${A}
    patch -p0 < ${FILESDIR}/mpg321-0.1.5-ao.diff || die
}

src_compile() {
    ./configure --prefix=/usr --host=${CHOST} || die
    make || die
}

src_install () {
    make DESTDIR=${D} install || die
}
