# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/wcslib/wcslib-4.8.ebuild,v 1.1 2011/08/18 05:45:59 bicatali Exp $

EAPI=4
inherit eutils fortran-2

DESCRIPTION="Astronomical World Coordinate System transformations library"
HOMEPAGE="http://www.atnf.csiro.au/people/mcalabre/WCS/"
SRC_URI="ftp://ftp.atnf.csiro.au/pub/software/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="LGPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="doc fortran fits pgplot static-libs"

RDEPEND="fortran? ( virtual/fortran )
	fits? ( sci-libs/cfitsio )
	pgplot? ( sci-libs/pgplot )"
DEPEND="${RDEPEND}"

pkg_setup() {
	use fortran && fortran-2_pkg_setup
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
	emake check
}

src_install () {
	default
	use doc && dodoc *.pdf && dohtml html/*
	# static libs are same as shared (compiled with PIC)
	# so they are not compiled twice
	use static-libs || rm -f "${ED}"/usr/$(get_libdir)/lib*.a
}
