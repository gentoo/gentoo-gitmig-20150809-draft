# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/spqr/spqr-1.3.1.ebuild,v 1.1 2012/11/12 02:20:56 bicatali Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="Multithreaded multifrontal sparse QR factorization library"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/SPQR"
SRC_URI="http://dev.gentoo.org/~bicatali/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc metis static-libs tbb"
RDEPEND="
	>=sci-libs/cholmod-2
	tbb? ( dev-cpp/tbb )
	metis? ( >=sci-libs/cholmod-2[metis] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( virtual/latex-base )"

src_configure() {
	local myeconfargs+=(
		$(use_with doc)
		$(use_with metis partition)
		$(use_with tbb)
	)
	autotools-utils_src_configure
}
