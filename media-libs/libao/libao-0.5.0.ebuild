# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pbg1854@garnet.acns.fsu.edu>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libao/libao-0.5.0.ebuild,v 1.1 2001/02/05 01:52:53 achim Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="the audio output library"
SRC_URI="http://www.vorbis.com/files/beta3/${A}"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"
DEPEND=">=media-sound/esound-0.2.20"

src_compile() {
    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} --enable-shared --enable-static
    try make
}

src_install () {
    cd ${S}
    try make DESTDIR=${D} install
    
    echo "Removing docs installed by make install"
    rm -rf ${D}/usr/share/doc
    dodoc AUTHORS CHANGES COPYING README TODO
    dodoc doc/API doc/DRIVERS doc/USAGE doc/WANTED
}
