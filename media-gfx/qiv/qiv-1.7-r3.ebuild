# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/qiv/qiv-1.7-r3.ebuild,v 1.3 2002/07/23 05:18:07 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Quick Image Viewer"
SRC_URI="http://www.klografx.net/qiv/download/${P}-src.tgz"
HOMEPAGE="http://www.klografx.net/qiv"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="media-libs/libpng
	>=media-libs/tiff-3.5.5
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
