# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/glu/glu-3.4.1.ebuild,v 1.1 2001/05/01 23:03:41 drobbins Exp $

S=${WORKDIR}/Mesa-${PV}
DESCRIPTION="OpenGL like graphic library for Linux, this package only contains the glu and glut parts"
SRC_URI="http://download.sourceforge.net/mesa3d/MesaLib-${PV}.tar.bz2"
HOMEPAGE="http://mesa3d.sourceforge.net/"

DEPEND="virtual/glibc virtual/x11"

PROVIDE="virtual/glu"

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

    myconf="${myconf} --with-x --without-glut --disable-ggi-fbdev --without-ggi"

    try ./configure --prefix=/usr --sysconfdir=/etc/mesa --host=${CHOST} $myconf

    try make
}

src_install () {
    cd ${S}
    try make DESTDIR=${D} install
    cd ${D}/usr/lib

    rm -f libGL.*
    rm -f ../include/GL/gl.h
    rm -f ../include/GL/glx.h
    rm -f ../include/GL/osmesa.h

    ln -s libGLU.so.1.1.030400 libMesaGLU.so.3

    cd ${S}
    dodoc docs/*
}

