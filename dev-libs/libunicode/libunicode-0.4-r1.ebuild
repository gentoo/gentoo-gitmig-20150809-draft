# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header

A=${P}.gnome.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The Gnome Application Libraries"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}"

HOMEPAGE="http://www.gnome.org/"

DEPEND="virtual/glibc"

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/opt/gnome
  try pmake
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install

  dodoc AUTHORS COPYING.* ChangeLog NEWS README THANKS TODO
}




