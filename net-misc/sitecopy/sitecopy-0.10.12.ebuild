# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/net-misc/sitecopy/sitecopy-0.10.12.ebuild,v 1.1 2001/01/09 16:06:51 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="sitecopy is for easily maintaining remote web sites"
SRC_URI="http://www.lyra.org/sitecopy/${P}.tar.gz"
HOMEPAGE="http://www.lyr.org/sitecopy/"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --enable-libxml --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr install

}

