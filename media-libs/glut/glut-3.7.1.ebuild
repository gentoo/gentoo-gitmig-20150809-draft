# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glut/glut-3.7.1.ebuild,v 1.27 2006/04/13 13:33:16 flameeyes Exp $

inherit libtool eutils

MESA_VER="5.0"
DESCRIPTION="The OpenGL Utility Toolkit (GLUT)"
HOMEPAGE="http://www.opengl.org/resources/libraries/"
SRC_URI="mirror://sourceforge/mesa3d/MesaLib-${MESA_VER}.tar.bz2
	mirror://sourceforge/mesa3d/MesaDemos-${MESA_VER}.tar.bz2"

LICENSE="glut"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86 ~x86-fbsd"
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
	dosym libglut.so.${PV} /usr/$(get_libdir)/libglut.so.${PV//\.*/} \
		|| die "libraries"

	insinto /usr/include/GL
	doins "${S}"/include/GL/glut* || die "headers"
}
