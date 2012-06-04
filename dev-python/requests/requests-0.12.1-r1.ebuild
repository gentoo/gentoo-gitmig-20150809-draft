# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/requests/requests-0.12.1-r1.ebuild,v 1.1 2012/06/04 11:48:46 marienz Exp $

EAPI="4"
PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils eutils

DESCRIPTION="HTTP library for human beings"
HOMEPAGE="http://python-requests.org/ http://pypi.python.org/pypi/requests"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="app-misc/ca-certificates
	>=dev-python/chardet-1.0.0
	>=dev-python/oauthlib-0.1.0 <dev-python/oauthlib-0.2.0"

src_prepare() {
	# This is dead code that does not work with python 3, see
	# https://github.com/kennethreitz/requests/issues/596
	rm -rf requests/packages/oreos || die

	# Fix up dependencies (gentoo-specific), see patch for details
	epatch "${FILESDIR}/${P}-setup.py.patch"
}
