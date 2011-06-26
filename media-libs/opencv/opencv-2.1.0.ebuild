# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/opencv/opencv-2.1.0.ebuild,v 1.11 2011/06/26 14:56:25 ranger Exp $

EAPI=3

PYTHON_DEPEND="python? 2:2.6"

inherit cmake-utils eutils flag-o-matic python

MY_P=OpenCV-${PV}

DESCRIPTION="A collection of algorithms and sample code for various computer vision problems"
HOMEPAGE="http://opencv.willowgarage.com"
SRC_URI="mirror://sourceforge/${PN}library/${MY_P}.tar.bz2"

LICENSE="v4l? ( GPL-2 ) xine? ( GPL-2 ) BSD"
SLOT="0"
KEYWORDS="~amd64 ppc ~ppc64 ~x86"
IUSE="debug +deprecated examples ffmpeg gstreamer gtk ieee1394 ipp jpeg jpeg2k octave png python sse sse2 sse3 ssse3 test tiff v4l xine"

RDEPEND="
	sys-libs/zlib
	virtual/fortran
	ipp? ( sci-libs/ipp )
	ieee1394? (
		sys-libs/libraw1394
		media-libs/libdc1394:2 )
	ffmpeg? ( virtual/ffmpeg )
	gstreamer? ( media-libs/gstreamer )
	gtk? ( x11-libs/gtk+:2 )
	jpeg2k? ( media-libs/jasper )
	jpeg? ( virtual/jpeg )
	png? ( >=media-libs/libpng-1.4 )
	tiff? ( media-libs/tiff )
	xine? ( media-libs/xine-lib )
	octave? ( sci-mathematics/octave )"
DEPEND="${RDEPEND}
	octave? ( dev-lang/swig )
	python? ( deprecated? ( dev-lang/swig ) )
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

RESTRICT="test" #296681

pkg_setup() {
	fortran-2_pkg_setup
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	sed -i \
		-e "s:share/opencv/doc:share/doc/${PF}:" \
		CMakeLists.txt || die

	epatch "${FILESDIR}"/${P}-multilib.patch \
		"${FILESDIR}"/${P}-mmap.patch \
		"${FILESDIR}"/${PN}-2.0.0-libpng14.patch
}

src_configure() {
	append-cppflags -D__STDC_CONSTANT_MACROS #324259

	mycmakeargs=(
		"-DCMAKE_SKIP_RPATH=ON"
		$(cmake-utils_use_build examples)
		"-DBUILD_LATEX_DOCS=OFF"
		$(cmake-utils_use_build python NEW_PYTHON_SUPPORT)
		$(cmake-utils_use_build octave OCTAVE_SUPPORT)
		$(cmake-utils_use_build test TESTS)
		$(cmake-utils_use sse USE_SSE)
		$(cmake-utils_use sse2 USE_SSE2)
		$(cmake-utils_use sse3 USE_SSE3)
		$(cmake-utils_use ssse3 USE_SSSE3)
		$(cmake-utils_use examples INSTALL_C_EXAMPLES)
		$(cmake-utils_use_with ipp)
		"-DUSE_O3=OFF"
		$(cmake-utils_use_with ieee1394 1394)
		$(cmake-utils_use_with ffmpeg)
		$(cmake-utils_use_with gstreamer)
		$(cmake-utils_use_with gtk)
		$(cmake-utils_use_with jpeg2k jasper)
		$(cmake-utils_use_with jpeg)
		$(cmake-utils_use_with png)
		$(cmake-utils_use_with tiff)
		"-DWITH_UNICAP=OFF"
		$(cmake-utils_use_with v4l)
		$(cmake-utils_use_with xine)
		)

	if use octave; then
		mycmakeargs+=(
			$(cmake-utils_use examples INSTALL_OCTAVE_EXAMPLES)
			)
	fi

	if use python; then
		mycmakeargs+=(
			$(cmake-utils_use_build deprecated SWIG_PYTHON_SUPPORT)
			$(cmake-utils_use examples INSTALL_PYTHON_EXAMPLES)
			)
	fi

	cmake-utils_src_configure
}

pkg_postinst() {
	use python && python_mod_optimize opencv
}

pkg_postrm() {
	use python && python_mod_cleanup opencv
}
