# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/glut/glut-3.7.ebuild,v 1.1 2000/10/09 16:02:49 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GLUT API for Linux"
SRC_URI="http://reality.sgi.com/opengl/glut3/${A}"
HOMEPAGE="http://reality.sgi.com/opengl/glut3/glut3.html"

src_unpack() {
   unpack ${A}
   cd ${WORKDIR}
   mkdir lib
   cd lib
   ln -s /usr/X11R6/lib/libGL.so.1 libMesaGL.so
   ln -s /usr/X11R6/lib/libGLU.so.1 libMesaGLU.so
}

src_compile() {

    cd ${S}
    cp linux/Glut.cf .
    cp mkmkfiles.imake mkmkfiles.imake.orig
    sed -e "s:/bin/csh:/bin/tcsh:" mkmkfiles.imake.orig > mkmkfiles.imake
    unset LS_COLORS
    try ./mkmkfiles.imake
    cp linux/Makefile lib/glut
    cd ${S}/lib/glut
    try make
    ln -s libglut.so.3.7 libglut.so.3
    ln -s libglut.so.3.7 libglut.so
    cd ${S}
    try make
}

src_install () {

    cd ${S}
    insinto /usr/X11R6/include/GL
    doins include/GL/*.h
    into /usr/X11R6
    dolib lib/glut/libglut.so.3.7
    preplib /usr/X11R6
    prepallstrip
}


