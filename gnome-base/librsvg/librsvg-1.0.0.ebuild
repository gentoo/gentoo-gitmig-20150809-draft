# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="librsvg"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=gnome-base/gnome-libs-1.2.10
	>=media-libs/freetype-2.0.1
	>=gnome-base/libxml-1.8
	>=gnome-base/gdk-pixbuf-0.10"

src_compile() {                           
  try ./configure --host=${CHOST} --prefix=/opt/gnome \
	--sysconfdir=/etc/opt/gnome
  try make
}

src_install() {                               
  try make DESTDIR=${D} install
  dodoc AUTHORS COPYING ChangeLog NEWS README*
}



