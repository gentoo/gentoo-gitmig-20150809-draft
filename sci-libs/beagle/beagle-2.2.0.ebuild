# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/beagle/beagle-2.2.0.ebuild,v 1.4 2007/09/06 02:48:40 markusle Exp $

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
	doc? ( app-doc/doxygen )
	!app-misc/beagle"

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
