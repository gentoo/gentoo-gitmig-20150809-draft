# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/mesa/mesa-3.4-r1.ebuild,v 1.2 2001/02/15 18:16:54 achim Exp $

P=MesaLib-${PV}
A0=${P}.tar.bz2
A1=MesaDemos-${PV}.tar.bz2
A="${A0} ${A1}"
S=${WORKDIR}/Mesa-${PV}
DESCRIPTION="OpenGL like graphic library for Linux"
SRC_URI="http://download.sourceforge.net/mesa3d/${A0}
         http://download.sourceforge.net/mesa3d/${A1}"
HOMEPAGE="http://mesa3d.sourceforge.net/"

DEPEND="virtual/glibc
	    X? ( >=x11-base/xfree-4.0.2 )
        ggi? ( >=media-libs/libggi-2.0_beta3 )
        svga? ( >=media-libs/svgalib-1.4.2-r1 )"

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

    if [ "`use X`" ]
    then
      myconf="${myconf} --with-x"
    else
      myconf="${myconf} --without-x"
      rm -rf src-glut
    fi

    if [ -z "`use ggi`" ] || [ -z "`use fbcon`" ]
    then
      myconf="${myconf} --disable-ggi-fbdev --without-ggi"
    fi

    if [ -z "`use svga`" ]
    then
      myconf="${myconf} --without-svga"
    fi

    cp configure configure.orig
    sed -e "s:^ggi_confdir.*:ggi_confdir=/etc/ggi:" \
        -e "s:^ggi_libdir.*:ggi_libdir=\$prefix/lib:" \
        configure.orig > configure

    try ./configure --prefix=/usr --sysconfdir=/etc/mesa --host=${CHOST} $myconf

    if [ "`use ggi`" ] && [ "`use fbcon`" ]
    then
      cd ${S}/src/GGI
      cp Makefile Makefile.orig
      sed -e "s:^ggimesaconfdatadir.*:ggimesaconfdatadir = \${ggi_confdir}:" \
          Makefile.orig > Makefile

      cd ${S}/src/GGI/default
      cp stubs.c stubs.c.orig
      sed -e "s:Texture.Enabled:Texture.ReallyEnabled:" stubs.c.orig > stubs.c

      cd ${S}/src/GGI/include/ggi/mesa
      cp display_fbdev.h display_fbdev.h.orig
      sed -e "s:fbdev_hook:ggi_fbdev_priv:" display_fbdev.h.orig > display_fbdev.h

      cd ${S}
    fi

    try make

    if [ "`use ggi`" ]
    then
      cd ggi/ggiglut
      try make libglut_la_LIBADD=\"-lggi -lgg -L${S}/src/.libs -lGL\"
    fi
}

src_install () {


    if [ "`use ggi`" ]
    then
      cd ggi/ggiglut
      try make DESTDIR=${D} install
      cd ${D}/usr/lib
      cp libglut.la libglut.orig
      sed -e "s:-L${S}/src/.libs::g" libglut.orig > libglut.la
      rm libglut.orig
    fi
    cd ${S}
    try make DESTDIR=${D} install
    cd ${D}/usr/lib
    if [ "$PN" = "mesa-glu" ]
    then
        rm -f libGL.*

        rm -f ../include/GL/gl.h
        rm -f ../include/GL/glx.h
        rm -f ../include/GL/osmesa.h
    else
        ln -s libGL.so.2.1.030400 libMesaGL.so.3
    fi
    ln -s libGLU.so.1.1.030400 libMesaGLU.so.3


    cd ${S}
    dodoc docs/*
}

