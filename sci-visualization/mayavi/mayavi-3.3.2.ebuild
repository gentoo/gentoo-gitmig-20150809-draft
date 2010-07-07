# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/mayavi/mayavi-3.3.2.ebuild,v 1.2 2010/07/07 16:41:15 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils eutils

MY_PN="Mayavi"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="VTK based scientific data visualizer"
HOMEPAGE="http://code.enthought.com/projects/mayavi/ http://pypi.python.org/pypi/Mayavi"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"
#	doc? ( mirror://gentoo/${PN}-docs-${PV}.tar.bz2 )"

LICENSE="BSD"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="doc qt4"

RDEPEND=">=dev-python/apptools-3.3.2
	dev-python/configobj
	>=dev-python/enthoughtbase-3.0.5
	>=dev-python/envisagecore-3.1.2
	>=dev-python/envisageplugins-3.1.2
	dev-python/ipython
	dev-python/numpy
	>=dev-python/traitsgui-3.4.0[qt4?,wxwidgets]
	dev-python/wxpython:2.8[opengl]
	>=sci-libs/vtk-5[python]
	qt4? ( dev-python/PyQt4[X,opengl] )"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}"/${MY_P}

PYTHON_MODNAME="enthought"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	# documentation generation requires X
	#epatch "${FILESDIR}"/${P}-nodocs.patch

	sed \
		-e "s/self.run_command('build_docs')/pass/" \
		-e "/setupdocs>=1.0/d" \
		-i setup.py || die "sed setup.py failed"

	distutils_src_prepare
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
