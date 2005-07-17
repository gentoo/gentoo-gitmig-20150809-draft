# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glut/glut-3.7.1.ebuild,v 1.23 2005/07/17 06:00:38 vapier Exp $

inherit libtool eutils

MESA_VER="5.0"
DESCRIPTION="The OpenGL Utility Toolkit (GLUT)"
HOMEPAGE="http://www.opengl.org/resources/libraries/"
SRC_URI="mirror://sourceforge/mesa3d/MesaLib-${MESA_VER}.tar.bz2
	mirror://sourceforge/mesa3d/MesaDemos-${MESA_VER}.tar.bz2"

LICENSE="|| ( X11 GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="virtual/opengl
	virtual/glu
	!virtual/glut"
PROVIDE="virtual/glut"

S="${WORKDIR}/Mesa-${MESA_VER}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	elibtoolize
}

src_compile() {
	econf || die
	cd "${S}"/src-glut
	emake || die "emake failed"
}

src_install() {
	insinto /usr/$(get_libdir)
	newins "${S}"/src-glut/.libs/libglut.lai libglut.la || die "libtools"

	dolib.so "${S}"/src-glut/.libs/libglut.so.${PV}
	dosym libglut.so.${PV} /usr/$(get_libdir)/libglut.so || die "libraries"
	preplib

	insinto /usr/include/GL
	doins "${S}"/include/GL/glut* || die "headers"
}
