# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/siag/siag-3.4.7.ebuild,v 1.1 2001/04/28 06:27:32 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A free Office package for Linux"
SRC_URI="ftp://siag.nu/pub/siag/${P}.tar.gz"
HOMEPAGE="http://siag.nu/"


src_compile() {

    try ./configure --prefix=/opt/siag --mandir=/opt/siag/share/man --host=${CHOST} \
	--with-guile --with-gmp \
	--with-mysql --with-t1lib
    try make

}

src_install () {

    try make DESTDIR=${D} install

}

