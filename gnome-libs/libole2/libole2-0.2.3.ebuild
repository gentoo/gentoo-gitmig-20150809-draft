# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libole2"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=dev-libs/glib-1.2.8"


src_compile() {                           
  try ./configure --host=${CHOST} --prefix=/opt/gnome
  try make
}

src_install() {                               
  try make prefix=${D}/opt/gnome install

  dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
}



