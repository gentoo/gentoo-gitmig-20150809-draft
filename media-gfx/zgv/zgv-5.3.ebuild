# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom <ryan@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/zgv/zgv-5.3.ebuild,v 1.2 2001/05/16 11:36:45 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="zgv an svgalib console image viewer"
SRC_URI="http://www.svgalib.org/rus/zgv/"${A}
HOMEPAGE="http://www.svgalib.org/rus/zgv"

DEPEND=">=media-libs/svgalib-1.4.2
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.0.9
	>=sys-libs/zlib-1.1.3
	>=media-libs/tiff-3.5.5"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	cp Makefile Makefile.orig
	sed -e "s:-O2 -fomit-frame-pointer -finline-functions:${CFLAGS}:" \
	Makefile.orig > Makefile
}
src_compile() {

	try make
}

src_install() {
	dodir /usr/bin /usr/share/{info,man}
	make PREFIX=${D}/usr INFODIR=${D}/usr/share/info \
		MANDIR=${D}/usr/share/man install
        cd ${D}/usr/share/info
	rm dir*
	mv zgv zgv.info
	for i in 1 2 3 4
	do
	   mv zgv-$i zgv.info-$i
        done
	cd ${S}
	dodoc AUTHORS NEWS README README.fonts SECURITY TODO
}
