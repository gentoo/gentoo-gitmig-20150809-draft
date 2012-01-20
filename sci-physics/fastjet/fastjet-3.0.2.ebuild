# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/fastjet/fastjet-3.0.2.ebuild,v 1.1 2012/01/20 00:39:52 bicatali Exp $

EAPI=4
inherit autotools-utils fortran-2 flag-o-matic

DESCRIPTION="Fast implementation of several recombination jet algorithms"
HOMEPAGE="http://www.fastjet.fr/"
SRC_URI="${HOMEPAGE}/repo/${P}.tar.gz"

LICENSE="GPL-2 QPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cgal doc examples +plugins static-libs"

RDEPEND="cgal? ( sci-mathematics/cgal )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	plugins? ( virtual/fortran )"

src_configure() {
	use cgal && has_version sci-mathematics/cgal[gmp] && append-ldflags -lgmp
	myeconfargs+=(
		$(use_enable cgal)
		$(use_enable plugins allplugins)
		$(use_enable plugins allcxxplugins)
	)
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile
	use doc && doxygen Doxyfile
}

src_install() {
	autotools-utils_src_install
	use doc && dohtml html/*
	if use examples; then
		insinto /usr/share/doc/${PF}
		find example \
			-name Makefile -or Makefile.in -or Makefile.am -delete
		doins -r example/*
	fi
}
