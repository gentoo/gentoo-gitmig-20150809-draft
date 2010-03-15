# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/mayavi/mayavi-3.3.0.ebuild,v 1.4 2010/03/15 03:22:41 bicatali Exp $

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

SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz
	doc? ( mirror://gentoo/${PN}-docs-${PV}.tar.bz2 )"

RDEPEND=">=dev-python/apptools-3.3.0
	>=dev-python/enthoughtbase-3.0.3
	>=dev-python/envisagecore-3.1.1
	>=dev-python/envisageplugins-3.1.1
	>=dev-python/traitsgui-3.1.0
	dev-python/configobj
	dev-python/ipython
	>=dev-python/numpy-1.1
	>=sci-libs/vtk-5[python]
	dev-python/wxpython:2.8[opengl]
	qt4? ( dev-python/PyQt4[X,opengl] )"

DEPEND="dev-python/setuptools
	>=dev-python/numpy-1.1
	>=sci-libs/vtk-5[python]"

# tests require X
RESTRICT=test

S="${WORKDIR}"/${MY_P}
PYTHON_MODNAME=enthought

src_prepare() {
	# documentation generation requires X
	epatch "${FILESDIR}"/${P}-nodocs.patch
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
