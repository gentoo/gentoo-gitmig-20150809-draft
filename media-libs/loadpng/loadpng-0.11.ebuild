# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/loadpng/loadpng-0.11.ebuild,v 1.7 2004/07/14 20:18:26 agriffis Exp $

DESCRIPTION="load and save PNG files in Allegro programs"
HOMEPAGE="http://www.alphalink.com.au/~tjaden/loadpng/"
SRC_URI="http://www.alphalink.com.au/~tjaden/loadpng/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=media-libs/allegro-4.0.0
	>=media-libs/libpng-1.2.4
	>=sys-libs/zlib-1.1.4"

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/lib
	dodir /usr/include
	make prefix=${D}/usr install || die
}
