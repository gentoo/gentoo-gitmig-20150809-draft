# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/umfpack/umfpack-5.0.3.ebuild,v 1.1 2007/02/19 10:39:50 bicatali Exp $

inherit autotools eutils

MY_PN=UMFPACK

DESCRIPTION="Unsymmetric multifrontal sparse LU factorization library"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/umfpack"
SRC_URI="http://www.cise.ufl.edu/research/sparse/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
DEPEND="virtual/blas
	>=sci-libs/amd-2.0"
RESTRICT="test"
S="${WORKDIR}/${MY_PN}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-autotools.patch
	cd "${S}"
	rm -f Makefile */*akefile
	eautoreconf
}

src_test() {
	cd "${S}"/Demo
	# test is still buggy but worth testing
	make > test.log || die "test failed"
}

src_install() {
	emake DESTDIR="${D}" install || "emake install failed"
	dodoc README.txt Doc/ChangeLog
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins Doc/*.pdf
	fi
}
