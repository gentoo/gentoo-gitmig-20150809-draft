# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/wcslib/wcslib-4.12.ebuild,v 1.1 2012/03/02 05:41:28 bicatali Exp $

EAPI=4

inherit eutils fortran-2

DESCRIPTION="Astronomical World Coordinate System transformations library"
HOMEPAGE="http://www.atnf.csiro.au/people/mcalabre/WCS/"
SRC_URI="ftp://ftp.atnf.csiro.au/pub/software/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="LGPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="fortran fits pgplot static-libs"

RDEPEND="fortran? ( virtual/fortran )
	fits? ( sci-libs/cfitsio )
	pgplot? ( sci-libs/pgplot )"
DEPEND="${RDEPEND}"

pkg_setup() {
	use fortran && fortran-2_pkg_setup
}

src_prepare() {
	sed -i -e 's/COPYING\*//' GNUmakefile || die
}

src_configure() {
	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		$(use_enable static-libs static) \
		$(use_enable fortran) \
		$(use_with fits cfitsio) \
		$(use_with pgplot)
}

src_compile() {
	# nasty makefile, debugging means full rewrite
	emake -j1
}

src_test() {
	emake -j1 check
}

src_install () {
	default
	# static libs are same as shared (compiled with PIC)
	# so they are not compiled twice
	use static-libs || rm -f "${ED}"/usr/$(get_libdir)/lib*.a
}
