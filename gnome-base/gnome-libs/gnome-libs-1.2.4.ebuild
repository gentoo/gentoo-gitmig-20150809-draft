# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-libs/gnome-libs-1.2.4.ebuild,v 1.6 2000/11/03 02:44:51 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNOME Core Libraries"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=dev-libs/glib-1.2.8
	>=x11-libs/gtk+-1.2.8
	>=media-libs/imlib-1.9.8.1
	>=media-sound/esound-0.2.19
	>=media-libs/jpeg-6b
	>=media-libs/giflib-4.1.0
	>=media-libs/libpng-1.0.7
	>=media-libs/tiff-3.5.5
	>=media-libs/audiofile-0.1.9
	>=x11-base/xfree-4.0.1"

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




