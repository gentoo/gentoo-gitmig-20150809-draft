# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyOpenGL/PyOpenGL-2.0.0.44.ebuild,v 1.12 2003/06/22 12:15:59 liquidx Exp $

inherit virtualx

S="${WORKDIR}/${P}"

DESCRIPTION="Python OpenGL bindings"
HOMEPAGE="http://pyopengl.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyopengl/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc alpha"

DEPEND="virtual/python
	>=media-libs/glut-3.7-r2
	x11-base/xfree
	virtual/opengl"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/config.diff || die "patch failed"

}

src_compile() {

#	IN_X=`env | grep DISPLAY | wc -l`
#	if [ "$IN_X" -eq "0" ]; then
#		einfo "******************************"
#		einfo "You must have XWindows running"
#		einfo "in order to compile PyOpenGL. "
#		einfo "******************************"
#		die "please start xwindows before emerging"
#	fi

	export maketype="python setup.py build"
	virtualmake "$*" || die
#	python setup.py build || die "build failed"

}

src_install () {

	export maketype="python setup.py install --prefix=${D}/usr"
	virtualmake "$*" || die
	#python setup.py install --prefix=${D}/usr || die "install failed"

}
