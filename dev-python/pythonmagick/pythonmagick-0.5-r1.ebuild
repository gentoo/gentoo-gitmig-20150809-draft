# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pythonmagick/pythonmagick-0.5-r1.ebuild,v 1.2 2004/06/13 12:05:44 kloeri Exp $

inherit distutils

MY_PN=PythonMagick
MY_P=${MY_PN}-${PV}

S=${WORKDIR}/${MY_PN}

DESCRIPTION="Python bindings for GraphicsMagick"
#SRC_URI="http://www.procoders.net/download.php?fname=${MY_P}.tar.gz"
SRC_URI="http://www.procoders.net/downloads/${MY_P}.tar.gz"
HOMEPAGE="http://www.procoders.net/moinmoin/PythonMagick"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.2
	>=media-gfx/graphicsmagick-1.0.5
	>=dev-libs/boost-1.31
	>=dev-util/boost-jam-3.1.9"

src_compile() {
	cp ${FILESDIR}/Jamfile ${S}/
	cp ${FILESDIR}/boost-build.jam ${S}/
	cp ${FILESDIR}/Jamrules ${S}/

	distutils_python_version # sets PYVER/PYVER_MAJOR/PYVER_MINOR

	export BUILD=release
	export PYTHON_ROOT=/usr
	export PYTHON_VERSION="${PYVER_MAJOR}.${PYVER_MINOR}"
	export MAGICK_SRC_PATH=/usr/include/GraphicsMagick
	export MAGICK_LIB_PATH=/usr/lib/GraphicsMagick

	bjam || die
}

src_install() {
	cd ${WORKDIR}/PythonMagick  || die
	distutils_src_install
}
