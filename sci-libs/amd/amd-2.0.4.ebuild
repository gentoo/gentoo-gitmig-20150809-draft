# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/amd/amd-2.0.4.ebuild,v 1.1 2007/02/19 10:32:00 bicatali Exp $

inherit autotools eutils fortran

MY_PN=AMD
DESCRIPTION="Library to order a sparse matrix prior to Cholesky factorization"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/amd"
SRC_URI="http://www.cise.ufl.edu/research/sparse/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
DEPEND="sci-libs/ufconfig"

S="${WORKDIR}/${MY_PN}"

FORTRAN="gfortran g77 ifc"

src_unpack() {
	fortran_src_unpack
	cd "${WORKDIR}"
	epatch "${FILESDIR}"/${P}-autotools.patch
	cd "${S}"
	rm -f Makefile */*akefile
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || "emake install failed"
	dodoc README.txt Doc/ChangeLog
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins Doc/AMD_UserGuide.pdf
	fi
}
