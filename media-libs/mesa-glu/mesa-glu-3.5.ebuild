# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mesa-glu/mesa-glu-3.5.ebuild,v 1.12 2004/03/19 07:56:04 mr_bones_ Exp $

S=${WORKDIR}/Mesa-${PV}
DESCRIPTION="OpenGL like graphic library for Linux, this package only contains the glu and glut parts"
SRC_URI="http://download.sourceforge.net/mesa3d/MesaLib-${PV}.tar.bz2
		 http://download.sourceforge.net/mesa3d/MesaDemos-${PV}.tar.bz2"
HOMEPAGE="http://mesa3d.sourceforge.net/"

SLOT="3.5"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND="virtual/x11"
PROVIDE="virtual/glu virtual/glut"

src_compile() {
	local myconf

	use mmx \
		&& myconf="--enable-mmx" \
		|| myconf="--disable-mmx"

	use 3dnow \
		&& myconf="${myconf} --enable-3dnow" \
		|| myconf="${myconf} --disable-3dnow"

	use sse \
		&& myconf="${myconf} --enable-sse" \
		|| myconf="${myconf} --disable-sse"
	#--without-glut means that no glut is available on the system, 
	# so mesa should build its own
	myconf="${myconf} --with-x --without-glut --disable-ggi-fbdev --without-ggi"
	econf \
		--sysconfdir=/etc/mesa \
		${myconf} || die

	emake || die
}

src_install() {
	cd ${S}
	make DESTDIR=${D} install || die
	cd ${D}/usr/lib
	rm -f libGL.*
	rm -f ../include/GL/gl.h
	rm -f ../include/GL/glx.h
	rm -f ../include/GL/osmesa.h
	ln -s libGLU.so.1.* libMesaGLU.so.3
	cd ${S}
	dodoc docs/*
}

