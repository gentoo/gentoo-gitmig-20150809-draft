# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/arrayterator/arrayterator-1.0.1.ebuild,v 1.2 2009/09/08 17:12:56 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="This class creates a buffered iterator for reading big arrays in small contiguous blocks."
HOMEPAGE="http://pypi.python.org/pypi/arrayterator"
SRC_URI="http://cheeseshop.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-python/numpy-1.0_rc1"
DEPEND="${RDEPEND}
	>=dev-python/setuptools-0.6_rc3"
RESTRICT_PYTHON_ABIS="3.*"

src_test() {
	cd tests

	testing() {
		PYTHONPATH="../build-${PYTHON_ABI}/lib" "$(PYTHON)" -c "import test_stochastic; test_stochastic.test()"
	}
	python_execute_function testing
}

pkg_postinst() {
	python_mod_optimize arrayterator.py
}
