# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/rep-gtk/rep-gtk-0.15.ebuild,v 1.1 2001/01/09 20:30:28 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GTK/GDK bindings for the librep Lisp environment"
SRC_URI="ftp://rep-gtk.sourceforge.net/pub/rep-gtk/"${A}
HOMEPAGE="http://rep-gtk.sourceforge.net/"

DEPEND="
	>=x11-libs/gtk+-1.2.8
	>=dev-libs/librep-0.13.4
	gnome? ( >=gnome-base/libglade-0.14
		 >=gnome-base/gdk-pixbuf-0.9.0 )"
src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  if [ -n "`use gnome`" ]
  then
      try ./configure --host=${CHOST} --with-gnome --with-libglade
  else
      try ./configure --host=${CHOST} --without-gnome --without-libglade \
	--without-gdk-pixbuf --without-gnome-canvas-pixbuf
  fi
  try make
}

src_install() {                               
  cd ${S}
  try make DESTDIR=${D} install
  dodoc AUTHORS BUGS COPYING ChangeLog README* TODO
  docinto examples
  dodoc examples/*
}
