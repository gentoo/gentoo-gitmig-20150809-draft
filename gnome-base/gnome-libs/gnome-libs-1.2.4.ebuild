# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-libs/gnome-libs-1.2.4.ebuild,v 1.9 2000/11/22 12:23:28 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNOME Core Libraries"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=media-libs/imlib-1.9.8.1
	>=media-sound/esound-0.2.19
	>=gnome-base/ORBit-0.5.3"

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/opt/gnome --enable-prefer-db1
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
pkg_postinst() {

  ldconfig -r ${ROOT}

}



