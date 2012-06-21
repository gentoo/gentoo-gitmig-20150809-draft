# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfits/pyfits-3.0.8.ebuild,v 1.2 2012/06/21 16:29:41 xarthisius Exp $

EAPI=4

PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 2.7-pypy-*"
DISTUTILS_SRC_TEST=nosetests

inherit distutils eutils

DESCRIPTION="Provides an interface to FITS formatted files under python"
HOMEPAGE="http://www.stsci.edu/resources/software_hardware/pyfits http://pypi.python.org/pypi/pyfits"
SRC_URI="mirror://pypi/p/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-python/numpy
	dev-python/setuptools"
DEPEND="${RDEPEND}
	dev-python/stsci-distutils
	dev-python/d2to1"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

src_prepare() {
	epatch "${FILESDIR}"/${P}-debundle_zlib.patch
	distutils_src_prepare
}

src_test() {
	testing() {
		nosetests -w "$(ls -d build-${PYTHON_ABI}/lib*)"
	}
	python_execute_function testing
}
