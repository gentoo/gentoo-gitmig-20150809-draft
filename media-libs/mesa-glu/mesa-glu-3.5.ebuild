# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/mesa-glu/mesa-glu-3.5.ebuild,v 1.5 2002/07/11 06:30:39 drobbins Exp $

S=${WORKDIR}/Mesa-${PV}
DESCRIPTION="OpenGL like graphic library for Linux, this package only contains the glu and glut parts"
SRC_URI="http://download.sourceforge.net/mesa3d/MesaLib-${PV}.tar.bz2
		 http://download.sourceforge.net/mesa3d/MesaDemos-${PV}.tar.bz2"
HOMEPAGE="http://mesa3d.sourceforge.net/"

DEPEND="virtual/glibc virtual/x11"
PROVIDE="virtual/glu virtual/glut"

src_compile() {
	local myconf
	if [ "`use mmx`" ]
	then
		myconf="--enable-mmx"
	else
		myconf="--disable-mmx"
	fi
	if [ "`use 3dnow`" ]
	then
		myconf="${myconf} --enable-3dnow"
	else
		myconf="${myconf} --disable-3dnow"
	fi
	if [ "`use sse`" ]
	then
		myconf="${myconf} --enable-sse"
	else
		myconf="${myconf} --disable-sse"
	fi
	#--without-glut means that no glut is available on the system, so mesa should build its own
	myconf="${myconf} --with-x --without-glut --disable-ggi-fbdev --without-ggi"
	./configure --prefix=/usr --sysconfdir=/etc/mesa --host=${CHOST} $myconf || die
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

