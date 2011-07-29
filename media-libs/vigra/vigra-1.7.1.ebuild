# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/vigra/vigra-1.7.1.ebuild,v 1.5 2011/07/29 11:49:33 scarabeus Exp $

EAPI=3

MY_P=${P}-src
inherit base cmake-utils multilib

DESCRIPTION="C++ computer vision library with emphasize on customizable algorithms and data structures"
HOMEPAGE="http://hci.iwr.uni-heidelberg.de/vigra/"
SRC_URI="http://hci.iwr.uni-heidelberg.de/vigra/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc fftw hdf5 jpeg png test tiff"

RDEPEND="
	dev-libs/boost
	fftw? ( >=sci-libs/fftw-3 )
	hdf5? ( sci-libs/hdf5[-mpi] )
	jpeg? ( virtual/jpeg )
	png? ( media-libs/libpng )
	tiff? ( media-libs/tiff )
"
DEPEND="${RDEPEND}
	doc? (
		app-doc/doxygen
	)
"

PATCHES=(
	"${FILESDIR}/1.7.1-png-1.5.patch"
	"${FILESDIR}/1.7.1-automagicness.patch"
	"${FILESDIR}/1.7.1-hdf5.patch"
	"${FILESDIR}/1.7.1-gcc4.6.patch"
)

# Restrict tests due to miscompilations
RESTRICT="test"

src_configure() {
	local libdir=$(get_libdir)

	# required for ddocdir
	_check_build_dir init
	# vigranumpy needs python so i can't test
	# doc needs doxygen and python
	# walgrind no use for us since we restrict test
	# $(cmake-utils_use_with valgrind VALGRIND)
	local mycmakeargs=(
		"-DDOCDIR=${CMAKE_BUILD_DIR}/doc"
		"-DLIBDIR_SUFFIX=${libdir/lib}"
		"-DDOCINSTALL=share/doc/${PF}"
		"-DWITH_VALGRIND=OFF"
		"-DWITH_VIGRANUMPY=OFF"
		$(cmake-utils_use_enable doc DOC)
		$(cmake-utils_use_with png)
		$(cmake-utils_use_with jpeg)
		$(cmake-utils_use_with tiff)
		$(cmake-utils_use_with fftw FFTW3)
		$(cmake-utils_use_with hdf5)
		$(cmake-utils_use_build test TESTING)
		$(cmake-utils_use test CREATE_CTEST_TARGETS)
		$(cmake-utils_use test AUTOBUILD_TESTS)
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	use doc && cmake-utils_src_make doc
}

src_install() {
	cmake-utils_src_install

	# drop useless cmake files from libdir
	rm -rf "${ED}"/usr/$(get_libdir)/${PN}/
}
