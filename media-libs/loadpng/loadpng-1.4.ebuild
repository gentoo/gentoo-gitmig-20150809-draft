# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/loadpng/loadpng-1.4.ebuild,v 1.1 2005/11/25 18:24:23 vanquirius Exp $

inherit toolchain-funcs

DESCRIPTION="load and save PNG files in Allegro programs"
HOMEPAGE="http://tjaden.strangesoft.net/loadpng/"
SRC_URI="http://tjaden.strangesoft.net/loadpng/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-libs/allegro-4.0.0
	>=media-libs/libpng-1.2.4
	>=sys-libs/zlib-1.1.4"

src_unpack() {
	unpack ${A}
	# avoid hardcoded CC/CFLAGS
	sed -i -e "s:gcc:$(tc-getCC):g" "${S}"/Makefile
	sed -i -e "s:-W -Wall -O3:${CFLAGS}:g" "${S}"/Makefile
}

src_install() {
	dodir /usr/lib
	dodir /usr/include
	make prefix="${D}"/usr install || die
}
