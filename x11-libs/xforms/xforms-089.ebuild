# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xforms/xforms-089.ebuild,v 1.2 2001/06/08 22:43:03 achim Exp $

#P=
A=bxform-${PV}-glibc2.1.tgz
S=${WORKDIR}/${PN}
DESCRIPTION="A GUI Toolkit based on Xlib"
SRC_URI="ftp://ncmir.ucsd.edu/pub/xforms/linux-i386/elf/${A}"
HOMEPAGE="http://world.std.com/~xforms/"

DEPEND="virtual/x11"

src_compile () {
   try make
}
src_install () {

   into /usr/X11R6
   dolib FORMS/libforms.{a,so.*}
   dosym /usr/X11R6/lib/libforms.so.0.89 /usr/X11R6/lib/libforms.so
   insinto /usr/X11R6/include
   doins FORMS/forms.h
   doman FORMS/xforms.5
}

