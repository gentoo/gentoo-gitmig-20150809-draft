# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/odfpy/odfpy-0.9.2.ebuild,v 1.1 2009/12/19 17:21:47 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python API and tools to manipulate OpenDocument files"
HOMEPAGE="http://opendocumentfellowship.com/development/projects/odfpy http://pypi.python.org/pypi/odfpy"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="odf"

src_test() {
	testing() {
		pushd tests > /dev/null || die
		local test
		for test in test*.py; do
			echo -e "\e[1;31mRunning ${test}...\e[0m"
			PYTHONPATH="../build-${PYTHON_ABI}/lib" "$(PYTHON)" "${test}" || die "${test} failed with Python ${PYTHON_ABI}"
		done
		popd > /dev/null || die
	}
	python_execute_function testing
}
