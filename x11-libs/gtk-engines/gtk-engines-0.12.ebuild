# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk-engines/gtk-engines-0.12.ebuild,v 1.2 2001/06/04 00:16:12 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gtk-engines"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND="virtual/glibc virtual/x11
	>=media-libs/imlib-1.9.8.1"

src_compile() {                           
  try ./configure --host=${CHOST} --prefix=/usr/X11R6
  try make
}

src_install() {                               
  try make prefix=${D}/usr/X11R6 install
  dodoc AUTHORS COPYING* ChangeLog README NEWS
}




