# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/umfpack/umfpack-5.5.1.ebuild,v 1.5 2012/04/26 14:22:21 jlec Exp $

EAPI=4

inherit autotools eutils fortran-2

MY_PN=UMFPACK

DESCRIPTION="Unsymmetric multifrontal sparse LU factorization library"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/umfpack"
SRC_URI="http://www.cise.ufl.edu/research/sparse/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="doc metis static-libs"

RDEPEND="
	virtual/fortran
	virtual/blas
	sci-libs/amd
	metis? ( sci-libs/cholmod[metis] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-autotools.patch
	eautoreconf
}

src_configure() {
	econf \
		--with-blas="$(pkg-config --libs blas)" \
		$(use_enable static-libs static) \
		$(use_with metis cholmod)
}

src_install() {
	default
	dodoc README.txt Doc/ChangeLog
	use doc && dodoc Doc/*.pdf
}
