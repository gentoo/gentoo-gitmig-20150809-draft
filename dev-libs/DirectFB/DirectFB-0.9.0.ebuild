# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/DirectFB/DirectFB-0.9.0.ebuild,v 1.3 2001/05/10 01:52:55 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="DirectFB is a thin library on top of the Linux fb devices"
SRC_URI="http://www.directfb.org/download/${A}"
HOMEPAGE="http://www.directfb.org"

DEPEND="virtual/glibc >=media-libs/freetype-2.0.1 >=media-libs/jpeg-6
	>=media-libs/libpng-1.0.10"

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}
    cp Makefile Makefile.orig
    sed -e "s:examples::" Makefile.orig > Makefile
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
    docinto html
    dodoc docs/html/*.{png,html}
}

