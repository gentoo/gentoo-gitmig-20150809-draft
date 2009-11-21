# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyopengl/pyopengl-3.0.1_beta1.ebuild,v 1.1 2009/11/21 03:27:38 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="PyOpenGL"
MY_P="${MY_PN}-${PV/_beta/b}"

DESCRIPTION="Python OpenGL bindings"
HOMEPAGE="http://pyopengl.sourceforge.net/ http://pypi.python.org/pypi/PyOpenGL"
SRC_URI="http://pypi.python.org/packages/source/P/PyOpenGL/${MY_P}.tar.gz
	mirror://sourceforge/pyopengl/${MY_P}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="tk"
# Disabled doc useflag

RDEPEND="virtual/glut
	x11-libs/libXi
	x11-libs/libXmu
	virtual/opengl
	|| ( >=dev-lang/python-2.5[tk?]
		( dev-lang/python:2.4[tk?] dev-python/ctypes ) )"
DEPEND="${RDEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="OpenGL"

src_compile() {
	distutils_src_compile

	# upstream does not include docs in the tarball.
	#if use doc ; then
	#	einfo "Generating API docs as requested..."
	#	mkdir "${S}/api"
	#	cd "${S}/api"
	#	PYTHONPATH="${S}" "${python}" "${S}/documentation/pydoc/builddocs.py" || die "generating docs failed"
	#fi
}

src_install() {
	distutils_src_install

	# no docs to install
	#dohtml -r documentation/{images,style,*.html}

	#use doc && dohtml -r "${S}/api"
}
