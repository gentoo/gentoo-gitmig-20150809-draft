# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/chaco/chaco-4.1.0.ebuild,v 1.1 2012/01/17 06:17:57 bicatali Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils virtualx

DESCRIPTION="Enthought Tool Suite: Interactive plotting toolkit"
HOMEPAGE="http://code.enthought.com/projects/chaco/ http://pypi.python.org/pypi/chaco"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND=">=dev-python/enable-4
	dev-python/numpy"
DEPEND="dev-python/setuptools
	dev-python/numpy
	doc? (
		>=dev-python/enable-4
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
		!prefix? ( x11-base/xorg-server[xvfb] )
		x11-apps/xhost
	)
	test? (
		>=dev-python/enable-4
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
	)"

DOCS="docs/*.txt"

src_compile() {
	distutils_src_compile
	use doc && virtualmake -C docs html
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
