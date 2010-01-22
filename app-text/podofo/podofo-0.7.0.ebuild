# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/podofo/podofo-0.7.0.ebuild,v 1.4 2010/01/22 16:47:05 ssuominen Exp $

EAPI="2"

inherit cmake-utils multilib

DESCRIPTION="PoDoFo is a C++ library to work with the PDF file format."
HOMEPAGE="http://sourceforge.net/projects/podofo/"
SRC_URI="mirror://sourceforge/podofo/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="+boost debug test"

DEPEND="dev-lang/lua
	dev-libs/openssl
	>=dev-libs/STLport-5.1.5
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/jpeg:0
	media-libs/tiff
	sys-libs/zlib
	boost? ( dev-util/boost-build )
	test? ( dev-util/cppunit )"
RDEPEND="${DEPEND}"

src_prepare() {
	einfo "fixing LIBDIRNAME detection"
	sed -e "s:LIBDIRNAME \"lib\":LIBDIRNAME \"$(get_libdir)\":" \
		-i CMakeLists.txt || die "fixing LIBDIRNAME detection failed"
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DPODOFO_BUILD_SHARED=1
		-DPODOFO_HAVE_JPEG_LIB=1
		-DPODOFO_HAVE_TIFF_LIB=1
		-DWANT_FONTCONFIG=1
		-DUSE_STLPORT=1
		$(cmake-utils_use_want boost)
		$(cmake-utils_use_has test CPPUNIT)"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS ChangeLog NEWS TODO || die "dodoc failed"
}
