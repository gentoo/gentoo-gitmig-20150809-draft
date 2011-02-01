# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/mayavi/mayavi-3.4.1.ebuild,v 1.3 2011/02/01 19:05:53 bicatali Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils eutils

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
	doc? ( app-arch/unzip )"

S="${WORKDIR}"/${MY_P}

DOCS="docs/*.txt"
PYTHON_MODNAME="enthought"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_unpack() {
	default
	if use doc; then
		cd "${S}"/docs
		# building docs is buggy and requires X
		# so use the bundled ones
		unpack ./html.zip
		rm -rf html/*/_sources
	fi
}

src_prepare() {
	distutils_src_prepare
	sed -i \
		-e "s/self.run_command('gen_docs')/pass/" \
		-e "s/self.run_command('build_docs')/pass/" \
		setup.py || die "sed setup.py failed"
}

src_install() {
	find -name "*LICENSE*.txt" -delete
	distutils_src_install

	insinto /usr/share/doc/${PF}
	if use doc; then
		doins -r docs/html || die "Installation of documentation failed"
		dosym  /usr/share/doc/${PF}/html/mayavi \
			$(python_get_sitedir)/enthought/mayavi/html
		dosym  /usr/share/doc/${PF}/html/tvtk \
			$(python_get_sitedir)/enthought/tvtk/html
	fi

	if use examples; then
		doins -r examples || die "Installation of examples failed"
	fi

	newicon enthought/mayavi/core/ui/images/m2.png mayavi2.png
	make_desktop_entry mayavi2 "Mayavi2 2D/3D Scientific Visualization" mayavi2
}
