# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/promise/promise-0.2.1.ebuild,v 1.1 2010/01/06 12:04:59 djc Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Bytecode optimisation using staticness assertions."
HOMEPAGE="http://github.com/rfk/promise/ http://pypi.python.org/pypi/promise"
SRC_URI="http://pypi.python.org/packages/source/p/${PN}/${PF}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

DOCS="LICENSE.txt README.txt"

# test suite fails, http://github.com/rfk/promise/issues/#issue/2
src_test() {
	testing() {
		PROMISE_SKIP_TIMING_TESTS=1 PYTHONPATH="build-${PYTHON_ABI}/lib" nosetests-${PYTHON_ABI}
	}
	python_execute_function testing
}
