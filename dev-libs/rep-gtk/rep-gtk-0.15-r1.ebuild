# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/rep-gtk/rep-gtk-0.15-r1.ebuild,v 1.6 2001/07/30 06:53:54 blocke Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GTK/GDK bindings for the librep Lisp environment"
SRC_URI="http://prdownloads.sourceforge.net/rep-gtk/"${A}
HOMEPAGE="http://rep-gtk.sourceforge.net/"

DEPEND=">=x11-libs/gtk+-1.2.9
	>=dev-libs/librep-0.13.4
	gnome? ( >=gnome-base/libglade-0.16
		 >=media-libs/gdk-pixbuf-0.9.0-r1 )"

RDEPEND=">=x11-libs/gtk+-1.2.9
	gnome? ( >=gnome-base/libglade-0.16
		 >=media-libs/gdk-pixbuf-0.9.0-r1 )"

src_compile() {
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
  try make DESTDIR=${D} install
  dodoc AUTHORS BUGS COPYING ChangeLog README* TODO
  docinto examples
  dodoc examples/*
}
