# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/gdk-pixbuf/gdk-pixbuf-0.11.0.ebuild,v 1.1 2001/05/17 00:10:07 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNOME Image Library"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/"${A}

DEPEND=">=gnome-base/gnome-libs-1.2.13"

src_compile() {

  try ./configure --host=${CHOST} --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome
  try make
}

src_install() {

  try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome install
  dodoc AUTHORS COPYING* ChangeLog INSTALL README NEWS TODO
}






