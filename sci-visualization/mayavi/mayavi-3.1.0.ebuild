# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/mayavi/mayavi-3.1.0.ebuild,v 1.1 2009/01/15 10:31:48 bicatali Exp $

EAPI=2
inherit eutils distutils

MY_PN="Mayavi"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="VTK based scientific data visualizer"
HOMEPAGE="http://code.enthought.com/projects/mayavi"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

IUSE="doc examples"
SLOT="2"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

RDEPEND="dev-python/apptools
	dev-python/enthoughtbase
	dev-python/envisagecore
	dev-python/envisageplugins
	dev-python/traitsgui
	dev-python/configobj
	dev-python/ipython
	dev-python/wxpython:2.8
	>=dev-python/numpy-1.1
	>=sci-libs/vtk-5[python]"

DEPEND="dev-python/setuptools
	>=dev-python/numpy-1.1
	>=sci-libs/vtk-5[python]"
# doc needs X display
#	doc? ( dev-python/setupdocs )"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_prepare() {
	# remove docs and mlab which needs a display
	sed -i \
		-e "/self.run_command('build_docs')/d" \
		-e "/self.run_command('mlab_ref')/d" \
		setup.py || die
}

src_compile() {
	distutils_src_compile
	#if use doc; then
	#	${python} setup.py build_docs --formats=html,pdf \
	#		|| die "doc building failed"
	#fi
}

src_install() {
	find "${S}" -name \*LICENSE\*.txt -delete
	distutils_src_install
	dodoc docs/*.txt
	insinto /usr/share/doc/${PF}
	if use doc; then
		#doins -r build/docs/html build/docs/latex/*/* || die
		doins docs/pdf/*.pdf docs/pdf/*/*.pdf || die
	fi
	if use examples; then
		doins -r examples || die
	fi
	newicon enthought/mayavi/core/ui/images/m2.png mayavi2.png
	make_desktop_entry mayavi2 "Mayavi2 2D/3D Scientific Visualization" mayavi2
}
