# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $ Header: $

S=${WORKDIR}/${P}
DESCRIPTION="Library for overlaying text/glyphs in X-Windows \
X-On-Screen-Display plus binary for sending text from command line."
HOMEPAGE="http://www.ignavus.net/"
SRC_URI="http://www.ignavus.net/${P}.tar.gz"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86 sparc sparc64"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-Makefile-gentoo.diff
}
src_compile() {
	econf
	make || die
}
src_install () {
	cd ${S}
	insinto /usr/include
	doins xosd.h
	into /usr
	dolib.a libxosd.a
	dolib.so libxosd.so
	dobin osd_cat
	doman osd_cat.1 xosd.e 
	dodoc AUTHORS ChangeLog NEWS COPYING README
}
