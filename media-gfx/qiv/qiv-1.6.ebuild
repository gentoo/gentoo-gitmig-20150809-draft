# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/qiv/qiv-1.6.ebuild,v 1.2 2001/06/22 05:57:21 thread Exp $

#P=
S=${WORKDIR}/${P}
DESCRIPTION="Quick Image Viewer"
SRC_URI="http://www.klografx.net/qiv/download/${P}-src.tgz"
HOMEPAGE="http://www.klograft.net/qiv"

DEPEND="virtual/glibc sys-devel/gcc
	>=media-libs/tiff-3.5.5
	>=media-libs/libpng-1.0.7
	virtual/x11"

src_compile() {

    cat Makefile | sed s:/usr/local:/usr: > tmp
    mv tmp Makefile
    try make

}

src_install () {

    dodir /usr/bin
    dodir /usr/man/man1
    try make PREFIX=${D}usr install

}

