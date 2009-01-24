# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyopengl/pyopengl-3.0.0_beta8.ebuild,v 1.1 2009/01/24 16:44:53 patrick Exp $

EAPI="2"
NEED_PYTHON="2.4"
inherit distutils

MY_P=PyOpenGL-${PV/_beta/b}

DESCRIPTION="Python OpenGL bindings"
HOMEPAGE="http://pyopengl.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyopengl/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc tk"

RDEPEND="virtual/glut
	x11-libs/libXi
	x11-libs/libXmu
	virtual/opengl
	|| ( >=dev-lang/python-2.5[tk?]
		( dev-lang/python:2.4[tk?] dev-python/ctypes ) )"
DEPEND="${RDEPEND}
	dev-python/setuptools"

PYTHON_MODNAME="OpenGL"

S="${WORKDIR}/${MY_P}"

src_compile() {
	distutils_src_compile

	if use doc ; then
		einfo "Generating API docs as requested..."
		mkdir "${S}/api"
		cd "${S}/api"
		PYTHONPATH="${S}" "${python}" "${S}/documentation/pydoc/builddocs.py" || die "generating docs failed"
	fi
}

src_install() {
	distutils_src_install

	dohtml -r documentation/{images,style,*.html}

	use doc && dohtml -r "${S}/api"
}
