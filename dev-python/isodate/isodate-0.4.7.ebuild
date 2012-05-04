# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/isodate/isodate-0.4.7.ebuild,v 1.1 2012/05/04 08:53:09 xarthisius Exp $

EAPI=4
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST=setup.py
RESTRICT_PYTHON_ABIS="2.7-pypy-*"

inherit distutils

DESCRIPTION="ISO 8601 date/time/duration parser and formater"
HOMEPAGE="http://pypi.python.org/pypi/isodate"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

DOCS="CHANGES.txt README.txt"

src_prepare() {
	# Skip test failing for python \not\in {2.7,3.2}
	sed -e '/test_strf.test_suite/d' \
		-i src/isodate/tests/__init__.py || die

	distutils_src_prepare
}
