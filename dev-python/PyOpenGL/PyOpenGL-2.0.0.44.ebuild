# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyOpenGL/PyOpenGL-2.0.0.44.ebuild,v 1.16 2003/12/29 15:54:49 gmsoft Exp $

inherit distutils virtualx

S="${WORKDIR}/${P}"

DESCRIPTION="Python OpenGL bindings"
HOMEPAGE="http://pyopengl.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyopengl/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha hppa"

DEPEND="virtual/python
	>=media-libs/glut-3.7-r2
	x11-base/xfree
	virtual/opengl"

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/config.diff
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${P}-disable_togl.patch
}

src_compile() {
	export maketype="python"
	export python="virtualmake"
	distutils_src_compile
}

src_install () {
	export maketype="python"
	export python="virtualmake"
	distutils_src_install
}
