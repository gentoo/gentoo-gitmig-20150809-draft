# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glut/glut-3.7.1.ebuild,v 1.11 2003/09/06 23:59:48 msterret Exp $

inherit libtool

MESA_VER="5.0"
S="${WORKDIR}/Mesa-${MESA_VER}"
DESCRIPTION="The OpenGL Utility Toolkit (GLUT)"
SRC_URI="mirror://sourceforge/mesa3d/MesaLib-${MESA_VER}.tar.bz2
	mirror://sourceforge/mesa3d/MesaDemos-${MESA_VER}.tar.bz2"
HOMEPAGE="http://www.opengl.org/developers/documentation/glut/"

SLOT="0"
LICENSE="X11 | GPL-2"
KEYWORDS="x86 ~ppc sparc alpha amd64 hppa"

DEPEND="virtual/opengl
	virtual/glu"

PROVIDE="virtual/glut"

src_compile() {

	elibtoolize

	econf || die

	cd ${S}/src-glut

	emake || die
}

src_install() {

	insinto /usr/lib
	newins ${S}/src-glut/.libs/libglut.lai libglut.la

	dolib.so ${S}/src-glut/.libs/libglut.so.${PV}
	dosym libglut.so.${PV} /usr/lib/libglut.so
	preplib

	insinto /usr/include/GL
	doins ${S}/include/GL/glut*

	dodoc ${S}/docs/COPY*
}

