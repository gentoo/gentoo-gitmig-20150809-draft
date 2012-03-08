# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/eigen/eigen-3.0.5.ebuild,v 1.1 2012/03/08 03:04:01 dilfridge Exp $

EAPI="2"

inherit cmake-utils

DESCRIPTION="C++ template library for linear algebra: vectors, matrices, and related algorithms"
HOMEPAGE="http://eigen.tuxfamily.org/"
SRC_URI="http://bitbucket.org/eigen/eigen/get/${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="LGPL-2 GPL-3"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
SLOT="3"
IUSE="debug doc"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND="!dev-cpp/eigen:0"

PATCHES=(
	"${FILESDIR}"/${PN}-3.0.0-gcc46.patch
)

src_unpack() {
	unpack ${A}
	mv ${PN}* ${P}
}

src_configure() {
	# benchmarks (BTL) brings up damn load of external deps including fortran
	# compiler
	CMAKE_BUILD_TYPE="release"
	mycmakeargs=(
		-DEIGEN_BUILD_BTL=OFF
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	if use doc; then
		cd "${CMAKE_BUILD_DIR}"
		emake doc || die "building documentation failed"
	fi
}

src_install() {
	cmake-utils_src_install
	if use doc; then
		cd "${CMAKE_BUILD_DIR}"/doc
		dohtml -r html/* || die "dohtml failed"
	fi
}

src_test() {
	mycmakeargs=(
		-DEIGEN_BUILD_TESTS=ON
		-DEIGEN_TEST_NO_FORTRAN=ON
	)
	cmake-utils_src_configure
	cmake-utils_src_compile
	cmake-utils_src_test
}
