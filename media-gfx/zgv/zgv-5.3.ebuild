# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom <ryan@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/zgv/zgv-5.3.ebuild,v 1.1 2001/03/29 23:43:58 ryan Exp $

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

src_compile() {

	try make 
}

src_install() {

	make install
	dodoc AUTHORS NEWS README README.fonts SECURITY TODO
}
