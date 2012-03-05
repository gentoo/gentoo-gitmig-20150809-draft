# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/mayavi/mayavi-4.1.0-r1.ebuild,v 1.3 2012/03/05 10:53:03 jlec Exp $

EAPI=4

RESTRICT_PYTHON_ABIS="3.* *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils eutils virtualx

DESCRIPTION="Enthought Tool Suite: Scientific data 3-dimensional visualizer"
HOMEPAGE="http://code.enthought.com/projects/mayavi/ http://pypi.python.org/pypi/mayavi/"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz"

LICENSE="BSD"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND="
	dev-python/apptools
	dev-python/configobj
	dev-python/envisage
	dev-python/ipython
	dev-python/numpy
	dev-python/pyface
	dev-python/traitsui
	dev-python/wxpython"
CDEPEND="sci-libs/vtk[python]"
DEPEND="
	${CDEPEND}
	dev-python/setuptools
	test? (
		${RDEPEND}
		dev-python/wxpython[opengl]
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
	)"

DOCS="docs/*.txt"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# upstream backport
	epatch "${FILESDIR}"/${P}-vtkQt.patch
	distutils_src_prepare
}

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

	use doc && dohtml -r docs/build/mayavi/html/*

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi

	newicon mayavi/core/ui/images/m2.png mayavi2.png
	make_desktop_entry mayavi2 "Mayavi2 2D/3D Scientific Visualization" mayavi2
}
