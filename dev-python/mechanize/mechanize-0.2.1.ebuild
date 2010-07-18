# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mechanize/mechanize-0.2.1.ebuild,v 1.4 2010/07/18 13:48:23 nixnut Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="Stateful programmatic web browsing in Python"
HOMEPAGE="http://wwwsearch.sourceforge.net/mechanize/ http://pypi.python.org/pypi/mechanize"
SRC_URI="http://wwwsearch.sourceforge.net/${PN}/src/${P}.tar.gz"

LICENSE="|| ( BSD ZPL )"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc ~sparc x86 ~amd64-linux ~ia64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

DOCS="docs/*.txt"

src_test() {
	testing() {
		# Ignore warnings (http://github.com/jjlee/mechanize/issues/issue/13).
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
