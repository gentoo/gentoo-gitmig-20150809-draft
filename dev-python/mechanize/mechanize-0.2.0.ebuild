# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mechanize/mechanize-0.2.0.ebuild,v 1.4 2010/06/01 09:03:49 phajdan.jr Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="Stateful programmatic web browsing in Python"
HOMEPAGE="http://wwwsearch.sourceforge.net/mechanize/ http://pypi.python.org/pypi/mechanize"
SRC_URI="http://wwwsearch.sourceforge.net/${PN}/src/${P}.tar.gz"

LICENSE="|| ( BSD ZPL )"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~sparc x86 ~amd64-linux ~ia64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

DOCS="docs/*.txt"

src_prepare() {
	# Use distutils instead of setuptools.
	# (This can't be removed in the same ${PV} due to file->directory replacement.)
	sed -e 's/not hasattr(sys, "version_info")/True/' -i setup.py || die "sed in setup.py failed"

	# We don't run coverage tests or functional_tests
	# which access the network, just doctests and unit tests
	sed -e '/import coverage/d' -i test.py || die "sed in test.py failed"
}

src_test() {
	testing() {
		# ignore warnings http://github.com/jjlee/mechanize/issues/issue/13
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" -Wignore test.py
	}
	python_execute_function testing
}

src_install() {
	# Fix some paths.
	sed -i -e 's:../styles/:styles/:g' docs/html/*
	dohtml -r docs/html/ docs/styles
	distutils_src_install
}
