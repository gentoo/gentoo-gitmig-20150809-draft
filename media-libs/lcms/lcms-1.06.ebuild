# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-libs/lcms/lcms-1.06.ebuild,v 1.1 2001/02/22 16:44:19 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="lcms deals with color management stuff"
SRC_URI="http://www.littlecms.com/${A}"
HOMEPAGE="http://www.littlecms.com/index.htm"

DEPEND="virtual/glibc"

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install
    cd ${D}/usr/include/lcms
    cp lcms.h lcms.orig
    sed -e "s:#define VERSION.*::" \
        -e "s:#define PACKAGE.*::" \
        lcms.orig > lcms.h
    rm lcms.orig

    cd ${S}/profiles
    dodir /usr/share/lcms/profiles
    cp *.icm ${D}/usr/share/lcms/profiles
    cd ${S}

    dodoc AUTHORS COPYING ChangeLog README*
    docinto txt
    dodoc doc/*.txt

}

