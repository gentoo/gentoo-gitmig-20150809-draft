# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/codetools/codetools-4.0.0.ebuild,v 1.3 2012/01/17 06:19:00 bicatali Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils virtualx

DESCRIPTION="Enthought Tool Suite: Code analysis and execution tools"
HOMEPAGE="http://code.enthought.com/projects/code_tools/ http://pypi.python.org/pypi/codetools"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz"

IUSE="doc examples test"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND="dev-python/numpy
	>=dev-python/scimath-4
	>=dev-python/traits-4"

DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( dev-python/sphinx )
	test? (
		${RDEPEND}
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
	)"

src_compile() {
	distutils_src_compile
	use doc && emake -C docs html
}

src_test() {
	VIRTUALX_COMMAND="distutils_src_test" virtualmake
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
