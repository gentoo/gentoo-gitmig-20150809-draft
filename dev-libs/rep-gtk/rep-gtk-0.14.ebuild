# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/rep-gtk/rep-gtk-0.14.ebuild,v 1.2 2000/11/03 17:47:44 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GTK/GDK bindings for the librep Lisp environment"
SRC_URI="ftp://rep-gtk.sourceforge.net/pub/rep-gtk/"${A}
HOMEPAGE="http://rep-gtk.sourceforge.net/"

DEPEND=">=dev-libs/gmp-3.1
	>=gnome-base/gdk-pixbuf-0.9.0
	>=gnome-base/libglade-0.14
	>=dev-libs/librep-0.13.1"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --with-gnome --with-libglade
  try make
}

src_install() {                               
  cd ${S}
  try make DESTDIR=${D} install
  dodoc AUTHORS BUGS COPYING ChangeLog README* TODO
  docinto examples
  dodoc examples/*
}



