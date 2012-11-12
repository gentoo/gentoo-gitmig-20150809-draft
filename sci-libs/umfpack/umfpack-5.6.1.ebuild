# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/umfpack/umfpack-5.6.1.ebuild,v 1.1 2012/11/12 02:25:21 bicatali Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="Unsymmetric multifrontal sparse LU factorization library"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/umfpack"
SRC_URI="http://dev.gentoo.org/~bicatali/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~amd64-linux ~x86-fbsd ~x86-linux ~x86-macos"
IUSE="doc metis static-libs"

RDEPEND="
	>=sci-libs/amd-1.3
	virtual/blas
	metis? ( >=sci-libs/cholmod-2[metis] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( virtual/latex-base )"

src_configure() {
	local myeconfargs+=(
		--with-blas="$(pkg-config --libs blas)"
		$(use_with doc)
		$(use_with metis cholmod)
	)
	autotools-utils_src_configure
}
