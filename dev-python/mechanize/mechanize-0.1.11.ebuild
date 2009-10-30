# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mechanize/mechanize-0.1.11.ebuild,v 1.6 2009/10/30 12:27:36 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Stateful programmatic web browsing in Python"
HOMEPAGE="http://wwwsearch.sourceforge.net/mechanize/ http://pypi.python.org/pypi/mechanize"
SRC_URI="http://wwwsearch.sourceforge.net/${PN}/src/${P}.tar.gz"

LICENSE="|| ( BSD ZPL )"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc x86 ~amd64-linux ~ia64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND=">=dev-python/clientform-0.2.7"
RDEPEND="${DEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

DOCS="0.1-changes.txt"

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
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test.py
	}
	python_execute_function testing
}

src_install() {
	# Remove some files to prevent distutils_src_install from installing them.
	dohtml *.html
	rm -f README.html*

	distutils_src_install
}
