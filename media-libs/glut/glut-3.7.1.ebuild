# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glut/glut-3.7.1.ebuild,v 1.19 2004/07/30 03:15:49 tgall Exp $

inherit libtool gnuconfig

MESA_VER="5.0"
DESCRIPTION="The OpenGL Utility Toolkit (GLUT)"
HOMEPAGE="http://www.opengl.org/resources/libraries/"
SRC_URI="mirror://sourceforge/mesa3d/MesaLib-${MESA_VER}.tar.bz2
	mirror://sourceforge/mesa3d/MesaDemos-${MESA_VER}.tar.bz2"

LICENSE="X11 | GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu"
PROVIDE="virtual/glut"

S=${WORKDIR}/Mesa-${MESA_VER}

src_compile() {

	use ppc64 && gnuconfig_update

	elibtoolize
	econf || die

	cd ${S}/src-glut
	emake || die
}

src_install() {
	insinto /usr/lib
	newins ${S}/src-glut/.libs/libglut.lai libglut.la || die "libtools"

	dolib.so ${S}/src-glut/.libs/libglut.so.${PV}
	dosym libglut.so.${PV} /usr/lib/libglut.so || die "libraries"
	preplib

	insinto /usr/include/GL
	doins ${S}/include/GL/glut* || die "headers"

	dodoc ${S}/docs/COPY*
}
