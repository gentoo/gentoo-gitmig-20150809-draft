# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Desktop Team <desktop@gentoo.org>
# Author: Achim Gottinger <achim@gentoo.org>, Daniel Robbins <drobbins@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/media-libs/libpng/libpng-1.0.12.ebuild,v 1.2 2001/10/13 04:33:21 drobbins Exp

S=${WORKDIR}/${P}
DESCRIPTION="libpng"
SRC_URI="ftp://swrinde.nde.swri.edu/pub/png/src/${P}.tar.gz"
HOMEPAGE="http://www.libpng.org/"

DEPEND=">=sys-libs/zlib-1.1.4"

src_compile() {
	sed -e "s:ZLIBLIB=../zlib:ZLIBLIB=/usr/lib:"	\
		-e "s:ZLIBINC=../zlib:ZLIBINC=/usr/include:"	\
		-e "s:prefix=/usr:prefix=${D}/usr:" -e "s/-O3/${CFLAGS}/"	\
			scripts/makefile.linux > Makefile

	make || die
}

src_install() {
	dodir /usr/{include,lib}
	make 	\
		prefix=${D}/usr	\
		install || die

	doman *.[35]
	dodoc ANNOUNCE CHANGES KNOWNBUG LICENSE README TODO Y2KINFO
}
