# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/rep-gtk/rep-gtk-0.13-r1.ebuild,v 1.2 2000/08/16 04:37:58 drobbins Exp $

P=rep-gtk-0.13
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GTK/GDK bindings for the librep Lisp environment"
SRC_URI="ftp://rep-gtk.sourceforge.net/pub/rep-gtk/"${A}
HOMEPAGE="http://rep-gtk.sourceforge.net/"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --with-gnome --with-libglade
  make
}

src_install() {                               
  cd ${S}
  make DESTDIR=${D} install
  dodoc AUTHORS BUGS COPYING ChangeLog README* TODO
  docinto examples
  dodoc examples/*
}



