# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cssutils/cssutils-0.9.6.ebuild,v 1.1 2009/10/07 19:55:52 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_P=${P/_beta/b}
DESCRIPTION="A Python package to parse and build CSS Cascading Style Sheets."
HOMEPAGE="http://code.google.com/p/cssutils"
SRC_URI="http://cssutils.googlecode.com/files/${MY_P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-python/setuptools-0.6_rc7-r1"
DEPEND="${RDEPEND}
	test? ( dev-python/minimock )"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare

	sed -e "s/os.chdir(os.path.dirname(__file__)/& or '.'/" -i src/tests/test_cssutils.py || die "sed failed"
}

src_test() {
	testing() {
		cd "${S}/src/tests"
		local test
		for test in test_*.py; do
			echo -e "\e[1;31mRunning ${test}...\e[0m"
			PYTHONPATH="../../build-${PYTHON_ABI}/lib" "$(PYTHON)" "${test}" || ewarn "${test} failed with Python ${PYTHON_ABI}"
		done
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	rm -fr "${D}"usr/lib*/python*/site-packages/tests
}
