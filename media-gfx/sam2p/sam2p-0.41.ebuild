# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sam2p/sam2p-0.41.ebuild,v 1.1 2003/04/10 15:27:36 twp Exp $

DESCRIPTION="A utility to convert raster images to PDF and others"
HOMEPAGE="http://www.inf.bme.hu/~pts/sam2p/"
SRC_URI="http://www.inf.bme.hu/~pts/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gif"
DEPEND="virtual/glibc"

src_compile() {
	local myconf="--enable-lzw"
	use gif && myconf="${myconf} --enable-gif"
	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall
	dodoc README
}
