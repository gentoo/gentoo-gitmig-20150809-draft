# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom <ryan@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fbi/fbi-1.7.ebuild,v 1.1 2001/03/30 20:43:22 ryan Exp $

A=fbi_1.7.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="fbi a framebuffer image viewer"
SRC_URI="http://www.strusel007.de/linux/misc/"${A}
HOMEPAGE="http://www.strusel007.de/linux/fbi.html"

DEPEND=">=media-libs/jpeg-6b
	>=media-libs/netpbm-9.10"

src_compile() {

	try make 
}

src_install() {

	dodoc README
	dobin src/fbi
	cp src/fbi.man fbi.1
	doman fbi.1
}
