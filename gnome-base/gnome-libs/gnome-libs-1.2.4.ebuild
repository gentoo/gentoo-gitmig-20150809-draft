# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-libs/gnome-libs-1.2.4.ebuild,v 1.1 2000/08/14 15:42:03 achim Exp $

P=gnome-libs-1.2.4
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="gnome-base"
DESCRIPTION="GNOME Core Libraries"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnome-libs/"${A}
HOMEPAGE="http://www.gnome.org/"

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/opt/gnome 
  make
}

src_install() {                               
  cd ${S}
  make prefix=${D}/opt/gnome install
  prepman /opt/gnome

  into /opt/gnome
  dodir /usr/doc/${P}
  mv ${D}/opt/gnome/doc/* ${D}/usr/doc/${P}
  doman ${D}/usr/doc/${P}/*.3
  rm ${D}/usr/doc/${P}/*.3
  gzip ${D}/usr/doc/${P}/*
  rm -rf ${D}/opt/gnome/doc
  dodoc AUTHORS COPYING* ChangeLog README NEWS HACKING
}



