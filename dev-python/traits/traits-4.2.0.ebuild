# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/traits/traits-4.2.0.ebuild,v 1.1 2012/10/09 13:31:29 patrick Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils virtualx

DESCRIPTION="Enthought Tool Suite: Explicitly typed attributes for Python"
HOMEPAGE="http://code.enthought.com/projects/traits/ http://pypi.python.org/pypi/traits"
SRC_URI="http://www.enthought.com/repo/ETS/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc examples test"

RDEPEND="dev-python/numpy"
DEPEND="dev-python/setuptools
	doc? ( dev-python/sphinx )
	test? ( dev-python/numpy )"

DOCS="docs/*.txt"

src_prepare() {
	sed -i -e "s/'-O3'//g" setup.py
}

src_compile() {
	distutils_src_compile
	use doc && virtualmake -C docs html
}

src_install() {
	find -name "*LICENSE*.txt" -delete
	distutils_src_install

	use doc && dohtml -r docs/build/html/*

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
