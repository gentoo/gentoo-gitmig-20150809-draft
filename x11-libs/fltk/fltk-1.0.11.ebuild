# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fltk/fltk-1.0.11.ebuild,v 1.2 2001/06/04 00:16:12 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="C++ user interface toolkit for X and OpenGL."
SRC_URI="ftp://ftp.fltk.org/pub/fltk/${PV}/${P}-source.tar.bz2"
HOMEPAGE="http://www.fltk.org"
DEPEND="virtual/glibc virtual/x11 opengl? ( virtual/opengl virtual/glu )"
RDEPEND="virtual/glibc virtual/x11 opengl? ( virtual/opengl virtual/glu )"

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

    try make prefix=${D}/usr/X11R6 install
    dodoc CHANGES COPYING README*
    mv ${D}/usr/X11R6/share/doc/fltk ${D}/usr/share/doc/${PF}/html

}

