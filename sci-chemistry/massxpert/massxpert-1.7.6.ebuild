# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/massxpert/massxpert-1.7.6.ebuild,v 1.1 2008/06/08 09:20:57 je_fro Exp $

inherit eutils flag-o-matic cmake-utils

DESCRIPTION="A software suite to predict/analyze mass spectrometric data on (bio)polymers."
HOMEPAGE="http://massxpert.org/wiki/"
SRC_URI="http://download.tuxfamily.org/massxpert/source/${PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-util/cmake-2.4.7"
RDEPEND=">=x11-libs/qt-4.3.3
		x11-libs/libSM
		x11-libs/libICE
		x11-libs/libXi
		x11-libs/libXrender
		x11-libs/libXrandr
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libXt
		x11-libs/libXfixes
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libX11
		sys-libs/zlib
		media-libs/freetype
		media-libs/fontconfig
		media-libs/nas
		media-libs/libpng
		dev-libs/libxml2"

S="${WORKDIR}/${P}"
CMAKE_IN_SOURCE_BUILD="true"

pkg_setup() {

	if ! built_with_use '>=x11-libs/qt-4.3.3' accessibility ; then
		eerror "qt4 must be built with the accessibility USE flag."
		die "qt4 must be built with the accessibility USE flag.."
	fi
}

src_compile() {
	sed -e "s:/lib/:/$(get_libdir)/:g" -i CMakeLists.txt || \
		die "sed failed"

	tc-export CC CXX LD
	mycmakeargs="-D__LIB=$(get_libdir)"

	if use amd64 ; then
		append-flags -fPIC
	fi

	cmake-utils_src_compile
}
