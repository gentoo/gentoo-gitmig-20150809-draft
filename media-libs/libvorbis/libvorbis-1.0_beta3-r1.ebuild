# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pbg1854@garnet.acns.fsu.edu>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libvorbis/libvorbis-1.0_beta3-r1.ebuild,v 1.1 2001/02/13 14:29:41 achim Exp $


A=libvorbis-1.0beta3.tar.gz
S=${WORKDIR}/libvorbis-1.0beta3
DESCRIPTION="the Ogg Vorbis sound file format library"
SRC_URI="http://www.vorbis.com/files/beta3/${A}"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"

DEPEND=">=media-libs/libogg-1.0_beta3"

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}
    try make
}

src_install () {

    try make DESTDIR=${D} install

    echo "Removing docs installed by make install"
    rm -rf ${D}/usr/share/doc

    dodoc AUTHORS COPYING README todo.txt
    docinto txt
    dodoc doc/*.txt
    docinto html
    dodoc doc/*.{html,png}
    docinto html/vorbisenc
    dodoc doc/vorbisenc/*.{css,html}
    docinto html/vorbisfile
    dodoc doc/vorbisfile/*.{css,html}
}

