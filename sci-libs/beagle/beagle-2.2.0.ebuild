# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/beagle/beagle-2.2.0.ebuild,v 1.3 2005/08/24 16:30:29 phosphan Exp $

inherit libtool

IUSE="doc static"

DESCRIPTION="Open BEAGLE, a versatile EC/GA/GP framework"
SRC_URI="mirror://sourceforge/beagle/${P}.tar.gz"
HOMEPAGE="http://www.gel.ulaval.ca/~beagle/index.html"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=sys-devel/gcc-2.96
	sys-libs/zlib
	doc? ( app-doc/doxygen )"

src_compile() {
	elibtoolize
	econf --enable-optimization `use_enable static` || die
	emake || die

	use doc && doxygen beagle.doxygen
}

src_install () {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README TODO

	if use doc; then
		cp -pPR examples ${D}/usr/share/doc/${PF}
		dohtml refman/html/*
	fi
}
