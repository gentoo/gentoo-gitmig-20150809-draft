# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/coverage/coverage-3.2.ebuild,v 1.11 2010/04/16 15:12:59 ranger Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Measures code coverage during Python execution"
HOMEPAGE="http://nedbatchelder.com/code/coverage/ http://pypi.python.org/pypi/coverage"
SRC_URI="http://pypi.python.org/packages/source/c/coverage/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="test"

RDEPEND="dev-python/setuptools"
DEPEND="${RDEPEND}
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
