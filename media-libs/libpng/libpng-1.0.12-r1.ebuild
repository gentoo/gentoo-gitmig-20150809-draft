# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpng/libpng-1.0.12-r1.ebuild,v 1.10 2002/12/22 21:21:37 mholzer Exp $

S=${WORKDIR}/${P}
DESCRIPTION="libpng"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.libpng.org/"
SLOT="1.0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc "

DEPEND=">=sys-libs/zlib-1.1.3-r2"


src_compile() {
	sed -e "s:ZLIBLIB=../zlib:ZLIBLIB=/usr/lib:" \
		-e "s:ZLIBINC=../zlib:ZLIBINC=/usr/include:" \
		-e "s:prefix=/usr:prefix=${D}/usr:" \
		-e "s/-O3/${CFLAGS}/" \
		scripts/makefile.linux > Makefile
	make || die
}

src_install() {
	dodir /usr/{include,lib}
	make install prefix=${D}/usr || die
	doman *.[35]
	dodoc ANNOUNCE CHANGES KNOWNBUG LICENSE README TODO Y2KINFO
}
