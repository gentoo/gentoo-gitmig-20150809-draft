# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyOpenGL/PyOpenGL-2.0.0.44.ebuild,v 1.23 2004/04/10 04:35:11 mr_bones_ Exp $

inherit eutils distutils virtualx

DESCRIPTION="Python OpenGL bindings"
HOMEPAGE="http://pyopengl.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyopengl/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 ~mips"

DEPEND="virtual/python
	>=media-libs/glut-3.7-r2
	virtual/x11
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

pkg_setup () {
	if [ -e /etc/env.d/09opengl ]
	then
		VOID=$(cat /etc/env.d/09opengl | grep xfree)

		USING_XFREE=$?
		if [ ${USING_XFREE} -eq 1 ]
		then
			GL_IMPLEM=$(cat /etc/env.d/09opengl | cut -f5 -d/)
			opengl-update xfree
		fi
	else
		die "Could not find /etc/env.d/09opengl. Please run opengl-update."
	fi
}

pkg_postinst () {
	if [ ${USING_XFREE} -eq 1 ]
	then
		opengl-update ${GL_IMPLEM}
	fi
}
