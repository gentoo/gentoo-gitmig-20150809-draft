# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/vlc/vlc-0.1.99h.ebuild,v 1.1 2000/08/26 20:41:56 achim Exp $

P=vlc-0.1.99h
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="A Player for MPEG2 Videos"
SRC_URI="http://www.videolan.org/packages/0.1.99h/${A}"
HOMEPAGE="http://www.videolan.org/"


src_compile() {

    unset CFLAGS
    unset CXXFLAGS
    cd ${S}
    ./configure --prefix=/usr --host=${CHOST} \
	--enable-mmx --enable-dsp --enable-esd \
	--enable-fb --enable-sdl --enable-gnome --enable-x11
    make

}

src_install () {

    cd ${S}
    make prefix=${D}/usr install
    dodoc AUTHORS ChangeLog COPYING README TODO
    

}


