# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/jpeg/jpeg-6b-r2.ebuild,v 1.4 2002/07/16 11:36:47 seemant Exp $

MY_P=${PN}src.v${PV}
S=${WORKDIR}/${P}
DESCRIPTION="libjpeg"
SRC_URI="ftp://ftp.uu.net/graphics/jpeg/${MY_P}.tar.gz"
HOMEPAGE="http://www.ijg.org/"
DEPEND="virtual/glibc"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc"

src_compile() {

	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--enable-shared \
		--enable-static || die

	make || die
}

src_install() {

	dodir /usr/{include,lib,bin,share/man/man1}
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man/man1 \
		install || die

	dodoc README change.log structure.doc
}

