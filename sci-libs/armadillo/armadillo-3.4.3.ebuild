# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/armadillo/armadillo-3.4.3.ebuild,v 1.2 2012/11/10 09:54:29 jlec Exp $

EAPI=4

CMAKE_IN_SOURCE_BUILD=1

inherit cmake-utils

DESCRIPTION="Streamlined C++ linear algebra library"
HOMEPAGE="http://arma.sourceforge.net/"
SRC_URI="mirror://sourceforge/arma/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="atlas blas examples lapack"

RDEPEND="
	dev-libs/boost
	atlas? ( sci-libs/lapack-atlas )
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
	if use atlas; then
		mycmakeargs=(
			-DARMA_USE_ATLAS=ON
			-DCBLAS_FOUND=ON
			-DCLAPACK_FOUND=ON
			-DATLAS_INCLUDE_DIR="${EPREFIX}/usr/include/atlas/"
			-DCBLAS_LIBRARIES="$(pkg-config --libs cblas)"
			-DCLAPACK_LIBRARIES="-L${EPREFIX}/usr/lib64/lapack/atlas -llapack"
		)
	fi
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc README.txt *pdf
	dohtml *html
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
