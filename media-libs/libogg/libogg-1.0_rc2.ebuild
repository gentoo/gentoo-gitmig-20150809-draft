# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pbg1854@garnet.acns.fsu.edu>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libogg/libogg-1.0_rc2.ebuild,v 1.2 2001/08/27 16:40:02 danarmak Exp $

A=libogg-1.0rc2.tar.gz
S=${WORKDIR}/libogg-1.0rc2
DESCRIPTION="the Ogg media file format library"
SRC_URI="http://www.vorbis.com/files/rc2/unix/${A}"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"

DEPEND="virtual/glibc"

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}
    try make
}

src_install () {
    
    try make DESTDIR=${D} install
    
    # remove the docs installed by make install, since I'll install
    # them in portage package doc directory
    echo "Removing docs installed by make install"
    rm -rf ${D}/usr/share/doc
    dodoc AUTHORS CHANGES COPYING README
    docinto html
    dodoc doc/*.{html,png}
}
