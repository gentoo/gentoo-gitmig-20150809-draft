# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/jsonpickle/jsonpickle-0.3.1.ebuild,v 1.1 2009/12/12 20:06:49 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python library for serializing any arbitrary object graph into JSON."
HOMEPAGE="http://jsonpickle.github.com/ http://pypi.python.org/pypi/jsonpickle"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="|| ( >=dev-lang/python-2.6
	( dev-lang/python:2.5 dev-python/simplejson ) )"
DEPEND="${RDEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

src_prepare() {
	distutils_src_prepare

	# Fix exit status of runtests.py.
	sed -e "s/unittest.TextTestRunner/return &/" -e "s/main()$/sys.exit(not main().wasSuccessful())/" -i tests/runtests.py || die "sed failed"

	# thirdparty_tests.py requires dev-python/feedparser.
	sed -e "/thirdparty_tests/d" -i tests/runtests.py || die "sed failed"
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" tests/runtests.py
	}
	python_execute_function testing
}
