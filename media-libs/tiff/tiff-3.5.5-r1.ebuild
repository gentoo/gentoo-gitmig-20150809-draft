# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/tiff/tiff-3.5.5-r1.ebuild,v 1.2 2000/09/15 20:09:04 drobbins Exp $

P=tiff-v3.5.5
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libtiff"
SRC_URI="http://www.libtiff.org/"${A}
HOMEPAGE="http://www.libtiff.org/"

src_compile() {
    cd ${S}
    try ./configure --noninteractive
    cd libtiff
    cp Makefile Makefile.orig
    sed -e "s/-O/${CFLAGS}/" Makefile.orig > Makefile
    cd ../tools
    cp Makefile Makefile.orig
    sed -e "s/-O/${CFLAGS}/" Makefile.orig > Makefile
    cd ..
    try make
}

src_unpack() {
    unpack ${A}
    cd ${S}
    cp ${O}/files/config.site .
    echo "DIR_HTML=\"${D}/usr/doc/${PF}/html\"" >> config.site
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
	dodir /usr/doc/${PF}/html
	try make install
	prepman
	gzip ${D}/usr/doc/${PF}/html/*.html
	gzip ${D}/usr/doc/${PF}/html/images/*
        rm ${D}/usr/lib/libtiff.so.3
	mv ${D}/usr/lib/libtiff.so.3.5. ${D}/usr/lib/libtiff.so.3.5.5
	rm -r /tiff.sw.tools
}

