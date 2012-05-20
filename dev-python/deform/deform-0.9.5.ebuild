# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/deform/deform-0.9.5.ebuild,v 1.1 2012/05/20 15:47:51 floppym Exp $

EAPI="3"

SUPPORT_PYTHON_ABIS=1
PYTHON_DEPEND="2:2.6 3:3.2"
RESTRICT_PYTHON_ABIS="2.5 3.0 3.1"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

DESCRIPTION="Another form generation library"
HOMEPAGE="http://docs.pylonsproject.org/projects/deform/en/latest/ http://pypi.python.org/pypi/deform https://github.com/Pylons/deform"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="repoze"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

# Depend on peppercorn, translationstring and colander with Python 3 support
RDEPEND=">=dev-python/translationstring-1.1
	>=dev-python/colander-0.9.6
	>=dev-python/peppercorn-0.4
	>=dev-python/chameleon-1.2.3"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )
	test? ( dev-python/beautifulsoup:4 )"

# Include COPYRIGHT.txt because the license seems to require it.
DOCS="CHANGES.txt COPYRIGHT.txt README.txt"

src_compile() {
	distutils_src_compile
	if use doc; then
		emake -C docs html
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/_build/html/*
	fi
}
