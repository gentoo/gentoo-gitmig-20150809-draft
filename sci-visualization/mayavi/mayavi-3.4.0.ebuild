# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/mayavi/mayavi-3.4.0.ebuild,v 1.1 2010/10/18 14:49:12 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils eutils

MY_PN="Mayavi"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="VTK based scientific data visualizer"
HOMEPAGE="http://code.enthought.com/projects/mayavi/ http://pypi.python.org/pypi/Mayavi"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="doc qt4"

RDEPEND=">=dev-python/apptools-3.4.0
	dev-python/configobj
	>=dev-python/enthoughtbase-3.0.6
	>=dev-python/envisagecore-3.1.3
	>=dev-python/envisageplugins-3.1.3
	dev-python/ipython
	dev-python/numpy
	>=dev-python/traitsgui-3.5.0[qt4?,wxwidgets]
	dev-python/wxpython:2.8[opengl]
	>=sci-libs/vtk-5[python]
	qt4? ( dev-python/PyQt4[X,opengl] )"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}"/${MY_P}

PYTHON_MODNAME="enthought"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	distutils_src_prepare

	sed \
		-e "s/self.run_command('build_docs')/pass/" \
		-e "/setupdocs>=1.0/d" \
		-i setup.py || die "sed setup.py failed"
}

src_install() {
	find "${S}" -name "*LICENSE*.txt" -delete
	distutils_src_install
	dodoc docs/*.txt
	if use doc; then
		dohtml -A txt,py,inv -r "${WORKDIR}"/html/*
	fi
	newicon enthought/mayavi/core/ui/images/m2.png mayavi2.png
	make_desktop_entry mayavi2 "Mayavi2 2D/3D Scientific Visualization" mayavi2
}
