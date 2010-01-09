# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/cgal/cgal-3.5.1.ebuild,v 1.1 2010/01/09 12:17:29 ssuominen Exp $

EAPI=2
CMAKE_BUILD_TYPE=Release
inherit base multilib cmake-utils

MY_P=CGAL-${PV}

DESCRIPTION="C++ library for geometric algorithms and data structures"
HOMEPAGE="http://www.cgal.org/"
SRC_URI="http://gforge.inria.fr/frs/download.php/25109/${MY_P}.tar.gz"

LICENSE="LGPL-2.1 MIT QPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+cxx examples +gmp lapack qt4"

RDEPEND="dev-libs/boost
	dev-libs/mpfr
	sci-libs/taucs
	sys-libs/zlib
	x11-libs/libX11
	virtual/opengl
	gmp? (
		dev-libs/gmp
		cxx? ( dev-libs/gmp[-nocxx] )
	)
	lapack? ( virtual/lapack )
	qt4? ( x11-libs/qt-gui:4
		x11-libs/qt-opengl:4 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

DOCS="AUTHORS CHANGES* README"

src_prepare() {
	base_src_prepare

	sed -i \
		-e '/install(FILES AUTHORS/d' \
		CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs

	if use gmp; then
		mycmakeargs+=( $(cmake-utils_use_with cxx GMPXX) )
	else
		mycmakeargs+=( "-DWITH_GMPXX=OFF" )
	fi

	mycmakeargs+=(
		"-DCGAL_INSTALL_LIB_DIR=$(get_libdir)"
		"-DWITH_CGAL_Qt3=OFF"
		$(cmake-utils_use_with qt4 CGAL_Qt4)
		$(cmake-utils_use_with lapack CPACK)
		$(cmake-utils_use_with gmp)
		"-DWITH_LEDA=OFF"
		$(cmake-utils_use_with examples DEMOS)
		$(cmake-utils_use_with examples)
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	dohtml -r doc_html/* || die
}
