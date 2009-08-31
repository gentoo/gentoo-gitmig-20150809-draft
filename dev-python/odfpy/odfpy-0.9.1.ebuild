# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/odfpy/odfpy-0.9.1.ebuild,v 1.1 2009/08/31 23:04:34 arfrever Exp $

EAPI="2"

NEED_PYTHON="2.4"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python interface to Open Document Format"
HOMEPAGE="http://opendocumentfellowship.com/development/projects/odfpy"
SRC_URI="http://pypi.python.org/packages/source/o/odfpy/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

RESTRICT_PYTHON_ABIS="3*"

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
