# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glut/glut-3.7-r2.ebuild,v 1.14 2004/03/19 07:56:03 mr_bones_ Exp $

MESA_VER="4.0.1"
S=${WORKDIR}/Mesa-${MESA_VER}
DESCRIPTION="The OpenGL Utility Toolkit (GLUT)"
SRC_URI="mirror://sourceforge/mesa3d/MesaLib-${MESA_VER}.tar.bz2
	mirror://sourceforge/mesa3d/MesaDemos-${MESA_VER}.tar.bz2"
HOMEPAGE="http://www.opengl.org/developers/documentation/glut/"

SLOT="0"
LICENSE="X11 | GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="virtual/opengl
	virtual/glu"

PROVIDE="virtual/glut"

src_compile() {

	./configure || die

	cd ${S}/src-glut

	emake || die
}

src_install() {

	insinto /usr/lib
	doins ${S}/src-glut/libglut.la
	dosed -e "s: -L${S}/si-glu : -L/usr/lib :" /usr/lib/libglut.la
	dosed -e "s:/usr/local/lib:/usr/lib:g" /usr/lib/libglut.la
	dosed -e "s:installed=no:installed=yes:" /usr/lib/libglut.la

	dolib.so ${S}/src-glut/.libs/libglut.so.${PV}.0
	dosym libglut.so.${PV}.0 /usr/lib/libglut.so
	preplib

	insinto /usr/include/GL
	doins ${S}/include/GL/glut*

	dodoc ${S}/docs/COPY*
}
