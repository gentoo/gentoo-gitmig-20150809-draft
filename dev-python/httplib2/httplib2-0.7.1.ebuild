# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/httplib2/httplib2-0.7.1.ebuild,v 1.2 2011/09/24 13:38:21 grobian Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A comprehensive HTTP client library"
HOMEPAGE="http://code.google.com/p/httplib2/ http://pypi.python.org/pypi/httplib2"
SRC_URI="http://httplib2.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x64-macos"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	distutils_src_prepare

	# cacerts.txt and other_cacerts.txt are missing in python3/httplib2 directory
	cp python2/httplib2/cacerts.txt python3/httplib2
	mkdir python3/httplib2/test
	cp python2/httplib2/test/other_cacerts.txt python3/httplib2/test
}

src_test() {
	testing() {
		pushd "python$(python_get_version --major)" > /dev/null
		"$(PYTHON)" httplib2test.py
		popd > /dev/null
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	dodoc README
	newdoc python3/README README-python3
}
