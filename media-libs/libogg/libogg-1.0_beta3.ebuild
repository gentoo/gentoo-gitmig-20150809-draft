# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pbg1854@garnet.acns.fsu.edu>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libogg/libogg-1.0_beta3.ebuild,v 1.1 2001/02/05 01:52:53 achim Exp $

A=libogg-1.0beta3.tar.gz
S=${WORKDIR}/libogg-1.0beta3
DESCRIPTION="the Ogg media file format library"
SRC_URI="http://www.vorbis.com/files/beta3/${A}"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"

DEPEND="virtual/glibc"

src_compile() {
    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make
}

src_install () {
    cd ${S}
    try make DESTDIR=${D} install
    
    # remove the docs installed by make install, since I'll install
    # them in portage package doc directory
    echo "Removing docs installed by make install"
    rm -rf ${D}/usr/share/doc
    dodoc AUTHORS CHANGES COPYING README
    docinto html
    dodoc doc/*.{html,png}
}
