# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/beagle/beagle-2.2.0.ebuild,v 1.6 2010/06/23 11:23:11 jlec Exp $

inherit libtool

DESCRIPTION="Open BEAGLE, a versatile EC/GA/GP framework"
SRC_URI="mirror://sourceforge/beagle/${P}.tar.gz"
HOMEPAGE="http://beagle.gel.ulaval.ca/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE="doc static"

RDEPEND="sys-libs/zlib
	!app-misc/beagle
	!dev-libs/libbeagle"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-2.96
	doc? ( app-doc/doxygen )"

src_compile() {
	elibtoolize
	econf --enable-optimization `use_enable static` || die
	emake || die

	use doc && doxygen beagle.doxygen
}

src_install () {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README TODO

	if use doc; then
		cp -pPR examples "${D}"/usr/share/doc/${PF}
		dohtml refman/html/*
	fi
}
