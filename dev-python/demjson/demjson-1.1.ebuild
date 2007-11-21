# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/demjson/demjson-1.1.ebuild,v 1.1 2007/11/21 22:13:49 hansmi Exp $

NEED_PYTHON=2.3

inherit distutils

KEYWORDS="~x86"

DESCRIPTION="Read and write JSON-encoded data, compliant with RFC 4627"
HOMEPAGE="http://deron.meranda.us/python/demjson/"
SRC_URI="http://deron.meranda.us/python/demjson/dist/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="test"

DEPEND="dev-python/setuptools"
RDEPEND=""

src_install() {
	distutils_src_install
	dohtml -r docs/*
}

src_test() {
	cd test && PYTHONPATH=.. python test_demjson.py || die "test failed"
}
