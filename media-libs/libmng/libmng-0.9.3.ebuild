# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmng/libmng-0.9.3.ebuild,v 1.1 2000/10/31 18:01:32 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${PN}
DESCRIPTION="Multiple Image Networkgraphics lib (animated png's)"
SRC_URI="http://download.sourceforge.net/libmng/${A}"
HOMEPAGE="http://www.libmng.com/"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr install
    dodoc CHANGES LICENSE README*
    dodoc doc/doc.readme doc/libmng.txt doc/*.png
}


