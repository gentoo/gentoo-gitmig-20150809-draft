# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/mayavi/mayavi-3.3.0.ebuild,v 1.1 2009/09/06 16:18:09 arfrever Exp $

EAPI="2"

inherit distutils eutils

MY_PN="Mayavi"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="VTK based scientific data visualizer"
HOMEPAGE="http://code.enthought.com/projects/mayavi"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

IUSE="doc examples qt4"
SLOT="2"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

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
# doc and test need X display
#	doc? ( dev-python/setupdocs )
#	test? ( >=dev-python/nose-0.10.3 )
RESTRICT="test"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"

src_prepare() {
	# remove docs and mlab which needs a display
	sed -i \
		-e "s/self.run_command('build_docs')/pass/" \
		-e "/self.run_command('gen_docs')/d" \
		setup.py || die
#		-e "/self.run_command('mlab_ref')/d" \
}

src_compile() {
	distutils_src_compile
	#if use doc; then
	#	${python} setup.py build_docs --formats=html,pdf \
	#		|| die "doc building failed"
	#fi
}

src_test() {
	PYTHONPATH="$(ls -d build/lib*)" "${python}" setup.py test || die "tests failed"
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
