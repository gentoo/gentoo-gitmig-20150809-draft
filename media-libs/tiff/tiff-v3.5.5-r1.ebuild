# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/tiff/tiff-v3.5.5-r1.ebuild,v 1.1 2000/08/08 13:24:41 achim Exp $

P=tiff-v3.5.5
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libtiff"
CATEGORY=media-libs
SRC_URI="http://www.libtiff.org/"${A}
HOMEPAGE="http://www.libtiff.org/"

src_compile() {
    cd ${S}
    ./configure --noninteractive
    cd libtiff
    cp Makefile Makefile.orig
    sed -e "s/-O/${CFLAGS}/" Makefile.orig > Makefile
    cd ../tools
    cp Makefile Makefile.orig
    sed -e "s/-O/${CFLAGS}/" Makefile.orig > Makefile
    cd ..
    make
}

src_unpack() {
    unpack ${A}
    cd ${S}
    cp ${O}/files/config.site .
    echo "DIR_HTML=\"${D}/usr/doc/${P}/html\"" >> config.site
    cp configure configure.orig
    sed -e "s:if \[ -r /lib/libc.*:if \[ -r /lib/libc\.so\.6 \]\; then:" \
	configure.orig > configure
}

src_install() {                 
	cd ${S}
	into /usr
	dodir /usr/bin
	dodir /usr/lib
	dodir /usr/man
	dodir /usr/doc
	dodoc COPYRIGHT README TODO VERSION
	dodir /usr/doc/${P}/html
	make install
	prepman
	gzip ${D}/usr/doc/${P}/html/*.html
	gzip ${D}/usr/doc/${P}/html/images/*
        rm ${D}/usr/lib/libtiff.so.3
	mv ${D}/usr/lib/libtiff.so.3.5. ${D}/usr/lib/libtiff.so.3.5.5
	rm -r /tiff.sw.tools
}
