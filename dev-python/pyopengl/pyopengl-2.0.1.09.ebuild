# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyopengl/pyopengl-2.0.1.09.ebuild,v 1.2 2005/01/25 20:36:39 eradicator Exp $

MY_P=${P/pyopengl/PyOpenGL}
S=${WORKDIR}/${MY_P}

inherit eutils distutils virtualx

DESCRIPTION="Python OpenGL bindings"
HOMEPAGE="http://pyopengl.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyopengl/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64"
IUSE=""

DEPEND="virtual/python
	virtual/glut
	virtual/x11
	virtual/opengl"

src_compile() {
	export maketype="python"
	export python="virtualmake"
	distutils_src_compile
}

src_install() {
	export maketype="python"
	export python="virtualmake"
	distutils_src_install
}
