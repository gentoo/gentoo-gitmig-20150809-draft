# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp/gimp-1.1.24-r1.ebuild,v 1.1 2000/08/08 13:20:27 achim Exp $

P=gimp-1.1.24
A=${P}.tar.bz2
S=${WORKDIR}/${P}
CATEGORY="media-gfx"
DESCRIPTION="GIMP"
SRC_URI="ftp://ftp.insync.net/pub/mirrors/ftp.gimp.org/gimp/v1.1/v1.1.24/"${A}
HOMEPAGE="http://www.gimp.org"

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/usr/X11R6 --disable-perl
  make
}

src_install() {                               
  cd ${S}
  make prefix=${D}/usr/X11R6 install
  prepman /usr/X11R6
  #cp -a /${D}/../../perl-*/build/* ${D} 
  dodoc AUTHORS COPYING ChangeLog* MAINTAINERS README* TODO
  dodoc docs/*.txt docs/*.gtkdoc docs/*.ps docs/Wilber* docs/quick_reference.tar.gz
  docinto html/libgimp
  dodoc devel-docs/libgimp/html/*.html
  docinto devel
  dodoc devel-docs/*.txt
}





