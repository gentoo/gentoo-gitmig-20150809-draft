# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp-print/gimp-print-4.0.4.ebuild,v 1.2 2000/12/11 16:27:20 achim Exp $

A=print-${PV}.tar.gz
S=${WORKDIR}/print-${PV}
DESCRIPTION="Gimp Plugin and Ghostscript driver for Gimp"
SRC_URI="http://download.sourceforge.net/gimp-print/"${A}
HOMEPAGE="http://gimp-print.sourceforge.net/"

DEPEND=">=media-gfx/gimp-1.1.29"

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





