# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpeg/jpeg-6b-r2.ebuild,v 1.3 2002/07/11 06:30:38 drobbins Exp $

A=jpegsrc.v6b.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libjpeg"
SRC_URI="ftp://ftp.uu.net/graphics/jpeg/${A}"
#SRC_URI="http://mirror/${A}"
HOMEPAGE="http://www.ijg.org/"
DEPEND="virtual/glibc"

src_compile() {

    try ./configure --prefix=/usr --mandir=/usr/share/man --enable-shared --enable-static
    try make
}

src_install() {

    dodir /usr/{include,lib,bin,share/man/man1}
    try make install prefix=${D}/usr mandir=${D}/usr/share/man/man1

	dodoc README change.log structure.doc
}

