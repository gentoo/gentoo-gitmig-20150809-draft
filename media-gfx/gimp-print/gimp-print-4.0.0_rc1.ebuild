# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp-print/gimp-print-4.0.0_rc1.ebuild,v 1.1 2000/10/29 20:36:59 achim Exp $

A=print-4.0.0rc1.tar.gz
S=${WORKDIR}/print-4.0.0rc1
DESCRIPTION="Gimp Plugin and Ghostscript driver for Gimp"
SRC_URI="http://download.sourceforge.net/gimp-print/"${A}
HOMEPAGE="http://gimp-print.sourceforge.net/"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr/X11R6 \
	--with-gimp-exec-prefix=/usr/X11R6
  cp Makefile Makefile.orig
  sed -e "s:^libexecdir = :libexecdir = ${D}/: " \
  Makefile.orig > Makefile	
  try make
}

src_install() {                               
  cd ${S}
  try make DESTDIR=${D} install-binPROGRAMS
  insinto /usr/X11R6/lib/gimp/1.1/plug-ins/
  insopts -m755
  doins print
  dodoc AUTHORS ChangeLog COPYING NEWS README* RELNOTES
}





