# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Thread <thread@threadbox.net>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/qiv/qiv-1.7-r2.ebuild,v 1.1 2001/12/06 22:37:47 jerrya Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Quick Image Viewer"
SRC_URI="http://www.klografx.net/qiv/download/${P}-src.tgz"
HOMEPAGE="http://www.klografx.net/qiv"

DEPEND="virtual/glibc
	>=media-libs/tiff-3.5.5
	>=media-libs/libpng-1.0.7
	>=media-libs/imlib-1.9.10
	virtual/x11"


src_compile() {
	make || die
}

src_install () {
	into /usr
	dobin qiv
	doman qiv.1
	dodoc README*
}
