# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/glut/glut-3.7-r1.ebuild,v 1.10 2002/07/11 06:30:38 drobbins Exp $

MESA_VER="4.0.1"
S=${WORKDIR}/Mesa-${MESA_VER}
DESCRIPTION=""
SRC_URI="mirror://sourceforge/mesa3d/MesaLib-${MESA_VER}.tar.bz2
	mirror://sourceforge/mesa3d/MesaDemos-${MESA_VER}.tar.bz2"
HOMEPAGE="http://www.opengl.org/developers/documentation/glut/"

DEPEND="virtual/glibc
	virtual/opengl"
	

PROVIDE="virtual/glut"

src_compile() {

	./configure || die

	cd ${S}/src-glut
			
	emake || die
}

src_install() {

	insinto /usr/lib
	doins ${S}/src-glut/libglut.la
	dolib.so ${S}/src-glut/.libs/libglut.so.${PV}.0
	dosym libglut.so.${PV}.0 /usr/lib/libglut.so
	insinto /usr/include/GL
	doins ${S}/include/GL/glut*

	dodoc ${S}/docs/COPYRIGHT
}

