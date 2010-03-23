# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/mayavi/mayavi-3.3.1.ebuild,v 1.1 2010/03/23 05:19:35 bicatali Exp $

EAPI="2"
inherit distutils eutils

DESCRIPTION="VTK based scientific data visualizer"
LICENSE="BSD"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="doc qt4"

MY_PN="Mayavi"
MY_P="${MY_PN}-${PV}"

HOMEPAGE="http://code.enthought.com/projects/${PN}/"

SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"
#	doc? ( mirror://gentoo/${PN}-docs-${PV}.tar.bz2 )"

RDEPEND=">=dev-python/apptools-3.3.1
	>=dev-python/enthoughtbase-3.0.4
	>=dev-python/envisagecore-3.1.2
	>=dev-python/envisageplugins-3.1.2
	>=dev-python/traitsgui-3.3.0[qt4?,wxwidgets]
	dev-python/configobj
	dev-python/ipython
	dev-python/numpy
	>=sci-libs/vtk-5[python]
	dev-python/wxpython:2.8[opengl]
	qt4? ( dev-python/PyQt4[X,opengl] )"

DEPEND="dev-python/setuptools
	dev-python/numpy
	>=sci-libs/vtk-5[python]"

# tests require X
RESTRICT=test

S="${WORKDIR}"/${MY_P}
PYTHON_MODNAME=enthought

src_prepare() {
	# documentation generation requires X
	#epatch "${FILESDIR}"/${P}-nodocs.patch
	sed -i \
		-e "s/setupdocs>=1.0//" \
		setup.py || die
}

src_install() {
	find "${S}" -name \*LICENSE\*.txt -delete
	distutils_src_install
	dodoc docs/*.txt
	if use doc; then
		dohtml -A txt,py,inv -r "${WORKDIR}"/html/*
	fi
	newicon enthought/mayavi/core/ui/images/m2.png mayavi2.png
	make_desktop_entry mayavi2 "Mayavi2 2D/3D Scientific Visualization" mayavi2
}

src_test() {
	PYTHONPATH="$(ls -d build/lib*)" "${python}" setup.py test || die "tests failed"
}
