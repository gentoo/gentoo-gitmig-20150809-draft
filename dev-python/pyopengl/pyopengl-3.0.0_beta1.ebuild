# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyopengl/pyopengl-3.0.0_beta1.ebuild,v 1.3 2008/06/29 10:34:02 tove Exp $

EAPI="1"
NEED_PYTHON="2.4"

inherit eutils distutils

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
	|| ( dev-lang/python:2.5
		( dev-lang/python:2.4 dev-python/ctypes ) )"
DEPEND="${RDEPEND}
	dev-python/setuptools"

PYTHON_MODNAME="OpenGL"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use tk && ! built_with_use dev-lang/python tk; then
		# Note: This isn't really fatal since the files get installed anyway
		#       The only thing where it matters is the generated API-documentation.
		#       Mainly to avoid bugs from people who don't read warnings and then ask
		#       where the ToGL API docs are.
		eerror "dev-lang/python has to be built with tk support to get tk-support in PyOpenGL."
		die "Missing tk USE-flag on dev-lang/python"
	fi
}

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
