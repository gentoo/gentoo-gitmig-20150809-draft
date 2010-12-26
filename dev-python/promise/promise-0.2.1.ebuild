# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/promise/promise-0.2.1.ebuild,v 1.3 2010/12/26 15:02:50 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Bytecode optimisation using staticness assertions."
HOMEPAGE="http://github.com/rfk/promise/ http://pypi.python.org/pypi/promise"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PF}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS="LICENSE.txt README.txt"

# test suite fails, http://github.com/rfk/promise/issues/#issue/2
src_test() {
	PROMISE_SKIP_TIMING_TESTS="1" distutils_src_test
}
