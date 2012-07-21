# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openimageio/openimageio-1.0.7-r1.ebuild,v 1.1 2012/07/21 14:22:43 flameeyes Exp $

EAPI=4

PYTHON_DEPEND="python? 2:2.7"

inherit cmake-utils eutils python multilib

DESCRIPTION="A library for reading and writing images"
HOMEPAGE="http://sites.google.com/site/openimageio/ http://github.com/OpenImageIO"
SRC_URI="http://github.com/OpenImageIO/oiio/tarball/Release-${PV} -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python opengl qt4 tbb jpeg2k opencv"

RDEPEND="dev-libs/boost[python?]
	media-libs/glew
	media-libs/ilmbase
	media-libs/libpng
	media-libs/openexr
	media-libs/tiff
	sci-libs/hdf5
	sys-libs/zlib
	virtual/jpeg
	opengl? (
		virtual/glu
		virtual/opengl
	)
	qt4? (
		x11-libs/qt-core:4
		x11-libs/qt-gui:4
		x11-libs/qt-opengl:4
	)
	tbb? ( dev-cpp/tbb )
	jpeg2k? ( media-libs/openjpeg )
	opencv? ( media-libs/opencv )
	dev-libs/pugixml"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}/src

hpkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_unpack() {
	unpack ${A}
	mv OpenImageIO-* "${WORKDIR}"/${P}
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-0.10.2-libpng15.patch

	# remove bundled code to make it build
	# https://github.com/OpenImageIO/oiio/issues/403
	rm */pugixml* || die

	# fix man page building
	# https://github.com/OpenImageIO/oiio/issues/404
	use qt4 || sed -i -e '/cli_tools/s:iv ::' doc/CMakeLists.txt
}

src_configure() {
	local mycmakeargs=(
		-DLIB_INSTALL_DIR=/usr/$(get_libdir)
		-DBUILDSTATIC=OFF
		-DLINKSTATIC=OFF
		$(cmake-utils_use_use opengl)
		$(cmake-utils_use_use qt4 QT)
		$(cmake-utils_use_use tbb)
		$(cmake-utils_use_use python)
		$(use python && echo -DPYLIB_INSTALL_DIR=$(python_get_sitedir))
		-DUSE_FIELD3D=OFF # missing in Portage
		$(cmake-utils_use_use jpeg2k OPENJPEG)
		-DUSE_OCIO=OFF # missing in portage
		$(cmake-utils_use_use opencv)
		-DUSE_EXTERNAL_PUGIXML=ON
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	dodoc ../{CHANGES,CREDITS,README} doc/CLA-{CORPORATE,INDIVIDUAL}

	insinto /usr/share/doc/${PF}/pdf
	doins doc/openimageio.pdf
}
