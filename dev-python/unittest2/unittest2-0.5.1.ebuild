# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/unittest2/unittest2-0.5.1.ebuild,v 1.6 2010/11/16 17:42:04 tomka Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="The new features in unittest for Python 2.7 backported to Python 2.4+."
HOMEPAGE="http://pypi.python.org/pypi/unittest2"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~s390 ~sparc x86"
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
