# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libxml/libxml-1.8.9.ebuild,v 1.3 2000/09/15 20:08:56 drobbins Exp $

P=libxml-1.8.9
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libxml"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/libxml/"${A}
HOMEPAGE="http://www.gnome.org/"

src_compile() {
  cd ${S}       
  LDFLAGS="-lncurses" try ./configure --host=${CHOST} --prefix=/opt/gnome
  try make
}

src_install() {
  cd ${S}
  try make install prefix=${D}/opt/gnome
  dodoc AUTHORS COPYING* ChangeLog NEWS README
}




