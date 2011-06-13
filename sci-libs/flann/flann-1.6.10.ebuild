# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/flann/flann-1.6.10.ebuild,v 1.2 2011/06/13 22:23:24 bicatali Exp $

EAPI=3

PYTHON_DEPEND="python? 2:2.5"

inherit python cmake-utils eutils

DESCRIPTION="Fast approximate nearest neighbor searches library"
HOMEPAGE="http://www.cs.ubc.ca/~mariusm/index.php/FLANN/FLANN"
SRC_URI="http://people.cs.ubc.ca/~mariusm/uploads/FLANN/${P}-src.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc mpi octave python static-libs test"

RDEPEND="sci-libs/hdf5[mpi?]
	mpi? ( dev-libs/boost[mpi] )
	octave? ( sci-mathematics/octave )
	python? ( dev-python/numpy )"
DEPEND="${DEPEND}
	app-arch/unzip
	test? ( dev-util/gtest )"

S=${WORKDIR}/${P}-src

src_prepare() {
	# bug #302621
	has_version sci-libs/hdf5[mpi] && export CXX=mpicxx
	# gentoo doc directory respected
	sed -i \
		-e "s:share/doc/flann:share/doc/${PF}:" \
		doc/CMakeLists.txt || die
	# python standard installation directory respected
	sed -i \
		-e "/share/d" \
		-e "/COMMAND/s:install:install --root=${ED} --no-compile:" \
		src/python/CMakeLists.txt || die
	# produce pure octave files
	# octave gentoo installation for .m files respected
	sed -i \
		-e 's/--mex//' \
		-e 's/\.mex/\.oct/' \
		-e '/FILES/s/${MEX_FILE}//' \
		-e 's:share/flann/octave:share/octave/site/m:' \
		-e "/CUSTOM_TARGET/a\INSTALL(FILES \${MEX_FILE} DESTINATION libexec/octave/site/oct/${CHOST})" \
		src/matlab/CMakeLists.txt || die
	# do not compile examples by default
	sed -i \
		-e '/add_subdirectory.*examples/d' \
		CMakeLists.txt || die
	# compile tests only when requested
	use test || sed -i -e '/add_subdirectory.*test/d' CMakeLists.txt
	# avoid automatic installation of pdf
	use doc || sed -i -e '/doc/d' CMakeLists.txt
}

src_configure() {
	local mycmakeargs=(
		"-DBUILD_C_BINDINGS=ON"
		$(cmake-utils_use_build octave MATLAB_BINDINGS)
		$(cmake-utils_use_build python PYTHON_BINDINGS)
		$(cmake-utils_use_use mpi)
	)
	cmake-utils_src_configure
}

src_test() {
	cd "${CMAKE_BUILD_DIR}"
	LD_LIBRARY_PATH="${PWD}/lib" PYTHONPATH="${S}/src/python" \
		make test || die
}

src_install() {
	cmake-utils_src_install
	dodoc README.md
	use static-libs || find "${ED}" -name 'lib*.a' -exec rm -rf '{}' '+'
}
