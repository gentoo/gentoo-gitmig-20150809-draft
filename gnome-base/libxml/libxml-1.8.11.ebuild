# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libxml/libxml-1.8.11.ebuild,v 1.1 2001/03/06 05:21:10 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libxml"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}
         ftp://gnome.eazel.com/pub/gnome/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=sys-libs/ncurses-5.2
        >=sys-libs/readline-4.1"

src_compile() {
  cd ${S}       
  LDFLAGS="-lncurses" try ./configure --host=${CHOST} --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome
  try make
}

src_install() {
  cd ${S}
  try make install prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome
  dodoc AUTHORS COPYING* ChangeLog NEWS README
}







