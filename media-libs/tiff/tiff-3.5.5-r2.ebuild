# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/tiff/tiff-3.5.5-r2.ebuild,v 1.1 2001/02/13 14:29:41 achim Exp $

P=${PN}-v${PV}
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libtiff"
SRC_URI="http://www.libtiff.org/"${A}
HOMEPAGE="http://www.libtiff.org/"

DEPEND=">=media-libs/jpeg-6b >=sys-libs/zlib-1.1.3-r2"

src_unpack() {

    unpack ${A}
    cd ${S}
    cp ${FILESDIR}/config.site-${PV}-r${PR} config.site
    echo "DIR_HTML=\"${D}/usr/share/doc/${PF}/html\"" >> config.site
    cp configure configure.orig
    sed -e "s:if \[ -r /lib/libc.*:if \[ -r /lib/libc\.so\.6 \]\; then:" \
	configure.orig > configure

}

src_compile() {

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

src_install() {

	dodir /usr/{bin,lib,share/man,share/doc/${PF}/html}

	dodir /usr/doc/${PF}/html
	try make install

	gzip ${D}/usr/doc/${PF}/html/*.html
	gzip ${D}/usr/doc/${PF}/html/images/*

    rm ${D}/usr/lib/libtiff.so.3
	mv ${D}/usr/lib/libtiff.so.3.5. ${D}/usr/lib/libtiff.so.3.5.5
        preplib /usr
	rm -r /tiff.sw.tools

    dodoc COPYRIGHT README TODO VERSION
}


