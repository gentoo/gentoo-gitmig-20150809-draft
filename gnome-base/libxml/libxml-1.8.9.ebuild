# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libxml/libxml-1.8.9.ebuild,v 1.2 2000/08/16 04:38:03 drobbins Exp $

P=libxml-1.8.9
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libxml"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/libxml/"${A}
HOMEPAGE="http://www.gnome.org/"

src_compile() {
  cd ${S}       
  LDFLAGS="-lncurses" ./configure --host=${CHOST} --prefix=/opt/gnome
  make
}

src_install() {
  cd ${S}
  make install prefix=${D}/opt/gnome
  dodoc AUTHORS COPYING* ChangeLog NEWS README
}




