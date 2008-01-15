# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glut/glut-3.7.1.ebuild,v 1.33 2008/01/15 09:04:50 nyhm Exp $

inherit autotools eutils multilib

MESA_VER="5.0"
DESCRIPTION="The OpenGL Utility Toolkit (GLUT)"
HOMEPAGE="http://www.opengl.org/resources/libraries/"
SRC_URI="mirror://sourceforge/mesa3d/MesaLib-${MESA_VER}.tar.bz2
	mirror://sourceforge/mesa3d/MesaDemos-${MESA_VER}.tar.bz2"

LICENSE="glut"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="virtual/opengl
	virtual/glu
	!media-libs/freeglut"
DEPEND="${RDEPEND}
	x11-proto/inputproto"

S=${WORKDIR}/Mesa-${MESA_VER}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Remove ancient libtool shipped in tarball
	rm m4/libtool.m4

	# Remove acinclude.m4 because we regenerate this into aclocal.m4 during
	# eautoreconf
	rm acinclude.m4

	epatch "${FILESDIR}/${P}-new-autotools.patch"
	epatch "${FILESDIR}/${P}-fix-GLU-linking.patch"
	AT_M4DIR=m4 eautoreconf
}

src_compile() {
	# --without-glut flag actually refers to whether mesa would build with or
	# without *external* glut, in this case we want the internal one
	econf --without-glut || die
	emake -C src-glut || die "emake failed"
}

src_install() {
	insinto /usr/$(get_libdir)
	newins src-glut/.libs/libglut.lai libglut.la || die "libtools"

	dolib.so src-glut/.libs/libglut.so.${PV} || die "dolib.so"
	dosym libglut.so.${PV} /usr/$(get_libdir)/libglut.so || die "libraries"
	dosym libglut.so.${PV} /usr/$(get_libdir)/libglut.so.${PV//\.*/} \
		|| die "libraries"

	insinto /usr/include/GL
	doins include/GL/glut* || die "headers"
}
