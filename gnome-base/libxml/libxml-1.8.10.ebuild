# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libxml/libxml-1.8.10.ebuild,v 1.2 2000/11/03 02:47:13 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libxml"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/"${A}
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.1
	>=dev-libs/glib-1.2.8"

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





