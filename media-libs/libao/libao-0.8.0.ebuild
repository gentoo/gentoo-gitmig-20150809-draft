# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pbg1854@garnet.acns.fsu.edu>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libao/libao-0.8.0.ebuild,v 1.2 2001/09/18 22:56:00 woodchip Exp $

A=${PN}-${PV}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="the audio output library"
SRC_URI="http://www.vorbis.com/files/rc2/unix/${A}"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"

DEPEND="virtual/glibc
        esd? ( >=media-sound/esound-0.2.22 )"

src_compile() {
    ./configure --prefix=/usr --host=${CHOST} --enable-shared --enable-static || die
    make || die
}

src_install () {
    make DESTDIR=${D} install || die
    
    rm -rf ${D}/usr/share/doc
    dodoc AUTHORS CHANGES COPYING README TODO
    dodoc doc/API doc/DRIVERS doc/USAGE doc/WANTED
}
