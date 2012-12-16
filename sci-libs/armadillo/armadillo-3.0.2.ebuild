# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/armadillo/armadillo-3.0.2.ebuild,v 1.5 2012/12/16 10:55:08 jlec Exp $

EAPI=4

CMAKE_IN_SOURCE_BUILD=1

inherit cmake-utils

DESCRIPTION="Streamlined C++ linear algebra library"
HOMEPAGE="http://arma.sourceforge.net/"
SRC_URI="mirror://sourceforge/arma/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE="blas doc lapack"

RDEPEND=">=dev-libs/boost-1.34
	blas? ( virtual/blas )
	lapack? ( virtual/lapack )"

DEPEND="${DEPEND}
	virtual/pkgconfig"

src_prepare() {
	# avoid the automagic cmake macros
	sed -i -e '/ARMA_Find/d' CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=()
	if use blas; then
		mycmakeargs+=(
			-DBLAS_FOUND=ON
			-DBLAS_LIBRARIES="$(pkg-config --libs blas)"
		)
	fi
	if use lapack; then
		mycmakeargs+=(
			-DLAPACK_FOUND=ON
			-DLAPACK_LIBRARIES="$(pkg-config --libs lapack)"
		)
	fi
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	use doc && dodoc docs/*pdf
}
