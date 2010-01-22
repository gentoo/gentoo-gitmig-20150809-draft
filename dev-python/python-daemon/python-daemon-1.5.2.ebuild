# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-daemon/python-daemon-1.5.2.ebuild,v 1.1 2010/01/22 13:10:46 djc Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Library to implement a well-behaved Unix daemon process."
HOMEPAGE="http://pypi.python.org/pypi/python-daemon"
SRC_URI="http://pypi.python.org/packages/source/p/${PN}/${P}.tar.gz"

LICENSE="PSF-2.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools
		test? ( dev-python/minimock )"
RDEPEND="dev-python/lockfile"

RESTRICT_PYTHON_ABIS="3.*"

DOCS="ChangeLog"

src_test() {
	PYTHONPATH=. ${python} setup.py test
}
