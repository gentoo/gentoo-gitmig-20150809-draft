# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/mesa/mesa-glu-3.4.ebuild,v 1.2 2000/11/27 22:48:59 achim Exp $

P=MesaLib-${PV}
A=${P}.tar.gz
S=${WORKDIR}/Mesa-${PV}
DESCRIPTION="OpenGL like graphic library for Linux"
SRC_URI="ftp://gd.tuwien.ac.at/graphics/libs/Mesa/${A}"
HOMEPAGE="http://mesa3d.sourceforge.net/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=x11-base/xfree-4.0.1"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr/X11R6 --sysconfdir=/etc/mesa --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
#    rm -f ${D}/usr/X11R6/lib/libGL.*

#    rm -f ${D}/usr/X11R6/include/GL/gl.h
#    rm -f ${D}/usr/X11R6/include/GL/glx.h
#    rm -f ${D}/usr/X11R6/include/GL/osmesa.h
    cd ${D}/usr/X11R6/lib
    ln -s libGLU.so.1.1.030400 libMesaGLU.so.3
    ln -s libGL.so.2.1.030400 libMesaGL.so.3

    cd ${S}
    dodoc docs/*
}

