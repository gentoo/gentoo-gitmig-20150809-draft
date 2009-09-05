# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/coverage/coverage-3.0.1.ebuild,v 1.1 2009/09/05 13:47:36 patrick Exp $

inherit distutils

DESCRIPTION="Measures code coverage during Python execution"
HOMEPAGE="http://nedbatchelder.com/code/modules/coverage.html"
SRC_URI="http://pypi.python.org/packages/source/c/coverage/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"
RDEPEND=""
DEPEND="${RDEPEND}
	test? ( >=dev-python/nose-0.10.3 )"

PYTHON_MODNAME="coverage.py"

src_test() {
	${python} setup.py nosetests || die
}
