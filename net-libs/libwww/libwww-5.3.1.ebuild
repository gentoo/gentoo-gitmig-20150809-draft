# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-libs/libwww/libwww-5.3.1.ebuild,v 1.1 2000/10/14 11:49:11 achim Exp $

A=w3c-${P}.tar.gz
S=${WORKDIR}/w3c-${P}
DESCRIPTION="A general-purpose client side WEB API"
SRC_URI="http://www.w3.org/Library/Distribution/${A}"
HOMEPAGE="http://www.w3.org/Library/"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} --with-zlib
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install

}

