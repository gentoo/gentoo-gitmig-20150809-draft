# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Desktop Team <desktop@gentoo.org>
# Author: Achim Gottinger <achim@gentoo.org>, Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmng/libmng-1.0.1.ebuild,v 1.2 2001/09/29 23:23:21 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Multiple Image Networkgraphics lib (animated png's)"
SRC_URI="http://download.sourceforge.net/libmng/${P}.tar.gz"
HOMEPAGE="http://www.libmng.com/"

DEPEND="virtual/glibc >=media-libs/jpeg-6b >=sys-libs/zlib-1.1.3 >=media-libs/lcms-1.0.6"

src_compile() {
    ./configure --prefix=/usr --with-lcms=/usr --host=${CHOST} || die
    make || die
}

src_install () {
    make prefix=${D}/usr install || die
    dodoc Changes LICENSE README*
    dodoc doc/doc.readme doc/libmng.txt doc/*.png
    doman doc/man/*
}


