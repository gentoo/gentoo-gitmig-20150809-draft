# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/oauth2/oauth2-1.5.169.ebuild,v 1.1 2011/05/04 07:25:31 djc Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Library for OAuth version 1.0a."
HOMEPAGE="http://pypi.python.org/pypi/oauth2"
SRC_URI="mirror://pypi/o/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/httplib2
		dev-python/setuptools
		test? ( dev-python/mox dev-python/coverage )"
RDEPEND=""

src_test() {
	testing() {
		"$(PYTHON)" setup.py test
	}
	python_execute_function testing
}
