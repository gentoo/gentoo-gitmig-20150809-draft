# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/mayavi/mayavi-3.4.1.ebuild,v 1.2 2011/01/30 23:13:11 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
VIRTUALX_REQUIRED="manual"

inherit distutils eutils virtualx

MY_PN="Mayavi"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="The Mayavi scientific data 3-dimensional visualizer"
HOMEPAGE="http://code.enthought.com/projects/mayavi/ http://pypi.python.org/pypi/Mayavi"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples qt4"

RDEPEND=">=dev-python/apptools-3.4.1
	dev-python/configobj
	>=dev-python/enthoughtbase-3.1.0
	>=dev-python/envisagecore-3.2.0
	>=dev-python/envisageplugins-3.2.0
	dev-python/ipython
	dev-python/numpy
	dev-python/setuptools
	>=dev-python/traitsgui-3.6.0[qt4?,wxwidgets]
	dev-python/wxpython:2.8[opengl]
	>=sci-libs/vtk-5[python]
	qt4? ( dev-python/PyQt4[X,opengl] )"
DEPEND="${RDEPEND}
	doc? (
		dev-python/sphinx
		media-fonts/font-cursor-misc
		media-fonts/font-misc-misc
		x11-apps/xhost
	)"

S="${WORKDIR}"/${MY_P}

DOCS="docs/*.txt"
PYTHON_MODNAME="enthought"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	distutils_src_prepare

	sed -e "s/self.run_command('build_docs')/pass/" -i setup.py || die "sed setup.py failed"
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd docs > /dev/null
		doc_generation() {
			emake html || die "Generation of documentation failed"
		}
		maketype="doc_generation" virtualmake
		popd > /dev/null
	fi
}

src_install() {
	find -name "*LICENSE*.txt" -delete
	distutils_src_install

	if use doc; then
		pushd docs/build/mayavi/html > /dev/null
		insinto /usr/share/doc/${PF}/html/mayavi
		doins -r [a-z]* _downloads _images _static || die "Installation of documentation failed"
		popd > /dev/null

		pushd docs/build/tvtk/html > /dev/null
		insinto /usr/share/doc/${PF}/html/tvtk
		doins -r [a-z]* _static || die "Installation of documentation failed"
		popd > /dev/null
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r examples/* || die "Installation of examples failed"
	fi

	newicon enthought/mayavi/core/ui/images/m2.png mayavi2.png
	make_desktop_entry mayavi2 "Mayavi2 2D/3D Scientific Visualization" mayavi2
}
