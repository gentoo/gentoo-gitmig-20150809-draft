# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmng/libmng-1.0.0.ebuild,v 1.1 2001/02/13 14:29:41 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Multiple Image Networkgraphics lib (animated png's)"
SRC_URI="http://download.sourceforge.net/libmng/${A}"
HOMEPAGE="http://www.libmng.com/"

DEPEND="virtual/glibc
	    >=media-libs/jpeg-6b >=sys-libs/zlib-1.1.3
        lcms? ( >=media-libs/lcms-1.0.6 )"

src_compile() {

    local myconf
    if [ "`use lcms`" ]
    then
      myconf="--with-lcms=/usr"
    else
      myconf="--without-lcms"
    fi
    try ./configure --prefix=/usr $myconf --host=${CHOST}
    try make

}

src_install () {

    try make prefix=${D}/usr install

    dodoc CHANGES LICENSE README*
    dodoc doc/doc.readme doc/libmng.txt doc/*.png

}


