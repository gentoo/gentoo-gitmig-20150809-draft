# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfits/pyfits-3.0.4.ebuild,v 1.1 2012/01/06 16:54:11 xarthisius Exp $

EAPI=4
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="*:2.6"

inherit distutils eutils

DESCRIPTION="Provides an interface to FITS formatted files under python"
HOMEPAGE="http://www.stsci.edu/resources/software_hardware/pyfits http://pypi.python.org/pypi/pyfits"
SRC_URI="http://pypi.python.org/packages/source/p/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="test"

RDEPEND="dev-python/numpy"
DEPEND="${RDEPEND}
	test? ( dev-python/nose )"

src_prepare() {
	sed -e 's/Exception, e/Exception as e/g' \
		-i lib/pyfits/{hdu/base.py,_release.py,tests/test_core.py} || die
	epatch "${FILESDIR}"/${P}-tests_python3.patch
	distutils_src_prepare
}

src_test() {
	testing() {
		local t
		for t in lib/${PN}/tests/test_*.py; do
			PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib*)"  "$(PYTHON)" "${t}" || die "${t} failed with Python ${PYTHON_ABI}"
		done
	}
	python_execute_function testing
}
