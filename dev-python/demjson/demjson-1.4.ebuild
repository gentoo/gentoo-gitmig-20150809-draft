# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/demjson/demjson-1.4.ebuild,v 1.1 2009/04/23 00:39:20 neurogeek Exp $

EAPI=1
NEED_PYTHON=2.3

inherit distutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="Read and write JSON-encoded data, compliant with RFC 4627"
HOMEPAGE="http://deron.meranda.us/python/demjson/"
SRC_URI="http://deron.meranda.us/python/${PN}/dist/${P}.tar.gz"
LICENSE="LGPL-3"
SLOT="0"
IUSE="doc test"

DEPEND="dev-python/setuptools"
RDEPEND=""

DOCS="AUTHORS.txt CHANGES.txt NEWS.txt THANKS.txt"

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/* || die "Failed to install docs"
	fi
}

src_test() {
	cd test && PYTHONPATH=.. python test_demjson.py || die "Test failed"
}
