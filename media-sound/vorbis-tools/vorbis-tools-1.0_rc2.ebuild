# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pbg1854@garnet.acns.fsu.edu>
# $Header: /var/cvsroot/gentoo-x86/media-sound/vorbis-tools/vorbis-tools-1.0_rc2.ebuild,v 1.2 2001/08/27 17:04:20 danarmak Exp $

A=vorbis-tools-1.0rc2.tar.gz
S=${WORKDIR}/vorbis-tools-1.0rc2
DESCRIPTION="tools for using the Ogg Vorbis sound file format"
SRC_URI="http://www.vorbis.com/files/rc2/unix/${A}"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"
DEPEND=">=media-libs/libvorbis-${PV}
        >=media-libs/libao-0.8.0"

src_compile() {
    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} 
    try make
}

src_install () {
    cd ${S}
    try make DESTDIR=${D} install
    rm -rf ${D}/usr/share/doc
    dodoc AUTHORS COPYING README
    docinto ogg123
    dodoc ogg123/ogg123rc-example
}
