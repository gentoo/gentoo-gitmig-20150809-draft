# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp-print/gimp-print-4.1.7.ebuild,v 1.1 2001/06/04 06:41:14 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Gimp Plugin and Ghostscript driver for Gimp"
SRC_URI="http://prdownloads.sourceforge.net/gimp-print/${A}"
HOMEPAGE="http://gimp-print.sourceforge.net/"

DEPEND=">=media-gfx/gimp-1.2.1"
RDEPEND="virtual/glibc"
src_unpack() {
  unpack ${A}
}

src_compile() {

  try ./configure --host=${CHOST} --prefix=/usr/X11R6 \
	--with-gimp-exec-prefix=/usr/X11R6
  cp Makefile Makefile.orig
  sed -e "s:^libexecdir = :libexecdir = ${D}/: " \
  Makefile.orig > Makefile
  try make

}

src_install() {

  try make prefix=${D}/usr/X11R6 install
  exeinto /usr/X11R6/lib/gimp/1.2/plug-ins/
  doexe src/gimp/print
  dodoc AUTHORS ChangeLog COPYING NEWS README* RELNOTES

}





