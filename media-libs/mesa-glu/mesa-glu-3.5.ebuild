# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/mesa-glu/mesa-glu-3.5.ebuild,v 1.1 2001/06/23 17:22:11 achim Exp $

P=MesaLib-${PV}
A0=${P}.tar.bz2
A1=MesaDemos-${PV}.tar.bz2
A="${A0} ${A1}"
S=${WORKDIR}/Mesa-${PV}
DESCRIPTION="OpenGL like graphic library for Linux, this package only contains the glu and glut parts"
SRC_URI="http://download.sourceforge.net/mesa3d/${A0}
         http://download.sourceforge.net/mesa3d/${A1}"
HOMEPAGE="http://mesa3d.sourceforge.net/"

DEPEND="virtual/glibc virtual/x11"

PROVIDE="virtual/glu virtual/glut"

src_unpack() {
  unpack ${A}
  cd ${S}/si-glu/include
  ln -s ../../include/GL GL
}

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

    ln -s libGLU.so.1.3.350 libMesaGLU.so.3


    cd ${S}
    dodoc docs/*
}

