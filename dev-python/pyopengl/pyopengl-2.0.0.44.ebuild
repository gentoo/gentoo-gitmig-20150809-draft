# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyopengl/pyopengl-2.0.0.44.ebuild,v 1.2 2004/07/30 03:37:29 tgall Exp $

MY_P=${P/pyopengl/PyOpenGL}
S=${WORKDIR}/${MY_P}

inherit eutils distutils virtualx

DESCRIPTION="Python OpenGL bindings"
HOMEPAGE="http://pyopengl.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyopengl/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64"
IUSE=""

DEPEND="virtual/python
	virtual/glut
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

src_install() {
	export maketype="python"
	export python="virtualmake"
	distutils_src_install
}

pkg_setup () {
	if [ -e /etc/env.d/09opengl ]
	then
		# Set up X11 implementation
		X11_IMPLEM_P="$(portageq best_version "${ROOT}" virtual/x11)"
		X11_IMPLEM="${X11_IMPLEM_P%-[0-9]*}"
		X11_IMPLEM="${X11_IMPLEM##*\/}"
		einfo "X11 implementation is ${X11_IMPLEM}."

		VOID=$(cat /etc/env.d/09opengl | grep ${X11_IMPLEM})

		USING_X11=$?
		if [ ${USING_X11} -eq 1 ]
		then
			GL_IMPLEM=$(cat /etc/env.d/09opengl | cut -f5 -d/)
			opengl-update ${X11_IMPLEM}
		fi
	else
		die "Could not find /etc/env.d/09opengl. Please run opengl-update."
	fi
}

pkg_postinst () {
	if [ ${USING_X11} -eq 1 ]
	then
		opengl-update ${GL_IMPLEM}
	fi
}
