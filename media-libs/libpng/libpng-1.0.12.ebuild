# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpng/libpng-1.0.12.ebuild,v 1.1 2001/06/21 20:48:16 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libpng"
SRC_URI="ftp://swrinde.nde.swri.edu/pub/png/src/${A}"
HOMEPAGE="http://www.libpng.org/"

DEPEND=">=sys-libs/zlib-1.1.3-r2"

src_compile() {

  sed -e "s:ZLIBLIB=../zlib:ZLIBLIB=/usr/lib:" \
	-e "s:ZLIBINC=../zlib:ZLIBINC=/usr/include:" \
	-e "s:prefix=/usr:prefix=${D}/usr:" \
	-e "s/-O3/${CFLAGS}/" \
	 scripts/makefile.linux > Makefile
  try make
}


src_install() {

    dodir /usr/{include,lib}

    try make install prefix=${D}/usr

 	doman *.[35]

	dodoc ANNOUNCE CHANGES KNOWNBUG LICENSE README TODO Y2KINFO

}
