# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/vlc/vlc-0.1.99i.ebuild,v 1.1 2000/11/26 20:54:18 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="A Player for MPEG2 Videos"
SRC_URI="http://www.videolan.org/packages/${PV}/${A}"
HOMEPAGE="http://www.videolan.org/"

DEPEND=">=media-libs/libsdl-1.1.5
	gnome? ( gnome-base/gnome-libs-1.2.4 )"
RDEPEND=$DEPEND

src_compile() {

    unset CFLAGS
    unset CXXFLAGS
    cd ${S}

    local myopts
    if [ -n "`use gnome`" ]
    then
	myopts="--enable-gnome --prefix=/opt/gnome"
    else
	myopts="--prefix=/usr/X11R6"
    fi
    try ./configure --host=${CHOST} ${myopts} \
	--enable-mmx --enable-dsp --enable-esd \
	--enable-fb --enable-sdl --enable-x11
    try make

}

src_install () {

    cd ${S}
    local myopts
    if [ -n "`use gnome`" ]
    then
	try make prefix=${D}/opt/gnome install
    else
	try make prefix=${D}/usr/X11R6 install
    fi
    dodoc AUTHORS ChangeLog COPYING README TODO
    

}


