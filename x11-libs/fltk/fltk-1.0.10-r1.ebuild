# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fltk/fltk-1.0.10-r1.ebuild,v 1.2 2001/04/23 19:59:42 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="C++ user interface toolkit for X and OpenGL."
SRC_URI="ftp://ftp.fltk.org/pub/fltk/${PV}/${P}-source.tar.bz2"
HOMEPAGE="http://www.fltk.org"
DEPEND="virtual/x11 opengl? ( virtual/opengl )"


src_compile() {

    try ./configure --prefix=/usr/X11R6 --host=${CHOST} --enable-shared
    if [ -z "`use opengl`" ]
    then
      cp config.h config.orig
      sed -e "s:#define HAVE_GL.*:#define HAVE_GL 0:" \
	config.orig > config.h
    fi   
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr/X11R6 install
    dodoc CHANGES COPYING README*
    mv ${D}/usr/X11R6/share/doc/fltk ${D}/usr/share/doc/${PF}/html

}

