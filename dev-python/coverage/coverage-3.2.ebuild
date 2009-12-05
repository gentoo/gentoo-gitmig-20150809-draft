# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/coverage/coverage-3.2.ebuild,v 1.1 2009/12/05 22:38:32 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Measures code coverage during Python execution"
HOMEPAGE="http://nedbatchelder.com/code/coverage/ http://pypi.python.org/pypi/coverage"
SRC_URI="http://pypi.python.org/packages/source/c/coverage/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="test"

RDEPEND=""
DEPEND="dev-python/setuptools
	test? ( >=dev-python/nose-0.10.3 )"

PYTHON_MODNAME="coverage"

src_test() {
	testing() {
		# Future version of dev-python/nose will support Python 3.
		[[ "${PYTHON_ABI}" == 3.* ]] && return

		"$(PYTHON)" setup.py build -b "build-${PYTHON_ABI}" nosetests
	}
	python_execute_function testing
}
