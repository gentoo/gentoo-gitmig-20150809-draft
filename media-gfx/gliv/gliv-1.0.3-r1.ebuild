# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gliv/gliv-1.0.3-r1.ebuild,v 1.1 2001/10/06 15:30:16 danarmak Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="An image viewer that uses OpenGL"
SRC_URI="http://gliv.tuxfamily.org/${A}"
HOMEPAGE="http://gliv.tuxfamily.org"

DEPEND="media-libs/imlib2 virtual/opengl"

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc COPYING README NEWS THANKS
}

