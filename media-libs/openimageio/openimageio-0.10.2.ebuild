# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openimageio/openimageio-0.10.2.ebuild,v 1.1 2011/10/15 22:18:46 ssuominen Exp $

EAPI=4

PYTHON_DEPEND="2:2.7"

inherit cmake-utils eutils python

DESCRIPTION="A library for reading and writing images"
HOMEPAGE="http://sites.google.com/site/openimageio/ http://github.com/OpenImageIO"
SRC_URI="http://github.com/OpenImageIO/oiio/tarball/Release-${PV} -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/boost
	media-libs/glew
	media-libs/ilmbase
	media-libs/jasper
	media-libs/libpng
	media-libs/openexr
	media-libs/tiff
	sci-libs/hdf5
	sys-libs/zlib
	virtual/glu
	virtual/jpeg
	virtual/opengl
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}/src

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_unpack() {
	unpack ${A}
	mv OpenImageIO-* "${WORKDIR}"/${P}
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-libpng15.patch \
		"${FILESDIR}"/${P}-multilib.patch

	sed -i \
		-e '/^add_subdirectory (doc)/d' \
		-e "/PYLIBDIR/s:\${CMAKE_INSTALL_PREFIX}/python:$(python_get_sitedir):" \
		CMakeLists.txt || die
}

src_install() {
	cmake-utils_src_install

	dodoc ../{CHANGES,CREDITS,README} doc/CLA-{CORPORATE,INDIVIDUAL}

	insinto /usr/share/doc/${PF}/pdf
	doins doc/openimageio.pdf
}
