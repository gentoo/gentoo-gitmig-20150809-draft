# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/sitecopy/sitecopy-0.10.12.ebuild,v 1.3 2001/02/27 03:06:16 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="sitecopy is for easily maintaining remote web sites"
SRC_URI="http://www.lyra.org/sitecopy/${P}.tar.gz"
HOMEPAGE="http://www.lyr.org/sitecopy/"
DEPEND=">=sys-libs/ncurses-5.2
	>=sys-libs/zlib-1.1.3
	>=gnome-base/libxml-1.8.10"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --enable-libxml --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr install

}

