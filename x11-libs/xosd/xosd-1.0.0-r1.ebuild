# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $ Header: $
S=${WORKDIR}/${P}
#S=${WORKDIR}/${NAME}-${PV}
DESCRIPTION="Library for overlaying text/glyphs in X-Windows \
X-On-Screen-Display plus binary for sending text from command line."
SRC_URI="http://www.ignavus.net/${P}.tar.gz"
#SRC_URI="http://www.ignavus.net/${NAME}-${PV}.tar.gz"
HOMEPAGE="http://www.ignavus.net/"
DEPEND="virtual/x11
	virtual/glibc"
RDEPEND="${DEPEND}"
LICENSE="GPL"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

src_unpack() {
	unpack ${A}
	cd ${S}
	./autogen.sh
	patch -p0 < ${FILESDIR}/Makefile-gentoo.diff
}
src_compile() {
	cd ${S}
	./configure --prefix=/usr --host=${CHOST} || die
	make || die
}
src_install () {
	cd ${S}
	insinto /usr/include
	doins src/xosd.h
	into /usr
	dolib.so src/.libs/libxosd.so src/.libs/libxosd.so.1 src/.libs/libxosd.so.1.0.0
	dolib.a src/.libs/libxosd.la
	dobin src/osd_cat
	doman man/osd_cat.1 man/xosd.3 
	dodoc AUTHORS ChangeLog NEWS COPYING README
}
