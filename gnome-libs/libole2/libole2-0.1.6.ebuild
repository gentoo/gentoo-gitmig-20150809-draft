# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header

P=libole2-0.1.6
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libole2"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/libole2/${A}"
HOMEPAGE="http://www.gnome.org/"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/opt/gnome --with-catgets
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install

  dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
}



