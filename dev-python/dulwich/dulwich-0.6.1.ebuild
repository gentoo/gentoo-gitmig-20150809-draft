# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dulwich/dulwich-0.6.1.ebuild,v 1.1 2010/07/23 19:05:57 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Dulwich is a pure-Python implementation of the Git file formats and protocols."
HOMEPAGE="http://samba.org/~jelmer/dulwich/ http://pypi.python.org/pypi/dulwich"
SRC_URI="http://samba.org/~jelmer/dulwich/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-macos ~x86-solaris"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

src_install() {
	distutils_src_install

	# Don't install tests.
	delete_tests() {
		rm -fr "${ED}$(python_get_sitedir)/dulwich/tests"
	}
	python_execute_function -q delete_tests
}
