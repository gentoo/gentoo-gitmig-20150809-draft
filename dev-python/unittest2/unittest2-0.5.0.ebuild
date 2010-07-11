# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/unittest2/unittest2-0.5.0.ebuild,v 1.1 2010/07/11 18:27:57 djc Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="The new features in unittest for Python 2.7 backported to Python 2.4+."
HOMEPAGE="http://pypi.python.org/pypi/unittest2"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}"

DOCS="README.txt"

src_test() {
	testing() {
		./unit2 discover
	}
	python_execute_function testing
}
