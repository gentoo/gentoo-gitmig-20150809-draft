# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/siag/siag-3.4.5.ebuild,v 1.1 2000/11/26 12:54:33 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A free Office package for Linux"
SRC_URI="ftp://siag.nu/pub/siag/${P}.tar.gz"
HOMEPAGE="http://siag.nu/"


src_compile() {

    cd ${S}
    try ./configure --prefix=/opt/siag --host=${CHOST} \
	--with-guile --with-gmp \
	--with-mysql --with-t1lib
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install

}

