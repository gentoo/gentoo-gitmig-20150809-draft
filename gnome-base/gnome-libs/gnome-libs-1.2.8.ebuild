# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-libs/gnome-libs-1.2.8.ebuild,v 1.2 2000/10/31 19:14:02 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNOME Core Libraries"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/opt/gnome 
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install
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




