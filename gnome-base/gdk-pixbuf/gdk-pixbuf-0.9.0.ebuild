# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gdk-pixbuf/gdk-pixbuf-0.9.0.ebuild,v 1.4 2000/10/31 05:23:49 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNOME Image Library"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/"${A}
DEPEND=">=media-libs/libpng-1.0.3 >=sys-libs/zlib-1.1.3 >=media-libs/jpeg-6b >=media-libs/tiff-3.5.5 >=x11-libs/gtk+-1.2.8 >=dev-libs/glib-1.2.8"

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/opt/gnome 
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING* ChangeLog INSTALL README NEWS TODO
}





