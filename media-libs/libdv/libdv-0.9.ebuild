# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdv/libdv-0.9.ebuild,v 1.1 2002/04/02 22:07:16 danarmak Exp $

S=${WORKDIR}/${P}
DESCRIPTION="video stream processing tool"
SRC_URI="http://prdownloads.sourceforge.net/${P}/${P}.tar.gz"
HOMEPAGE="http://${P}.sourceforge.net/"

DEPEND="sys-devel/gcc
	virtual/glibc
	virtual/x11
	sdl? ( media-libs/libsdl )
	>=dev-libs/glib-1.2.4
	>=x11-libs/gtk+-1.2.4
	dev-util/pkgconfig"

src_compile() {

    cd ${S}
    use sdl && myconf="$myconf --enable-sdl" || myconf="$myconf --disable-sdl"
    ./configure --prefix=/usr $myconf || die
    emake || die

}

src_install () {

    make DESTDIR=${D} install || die

}

