# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib/imlib-1.9.10.ebuild,v 1.3 2001/06/04 00:16:12 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="imlib"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}
	 http://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}
         ftp://gnome.eazel.com/pub/gnome/stable/sources/${PN}/${A}"

HOMEPAGE="http://www.gnome.org/"

DEPEND="virtual/glibc
	>=media-libs/giflib-4.1.0
	>=media-libs/libpng-1.0.7
	>=media-libs/tiff-3.5.5
	>=x11-libs/gtk+-1.2.10
	virtual/x11"

src_compile() {
  try  ./configure --host=${CHOST} --prefix=/usr/X11R6 --sysconfdir=/etc/X11/imlib
  try make
}

src_install() {
  try make prefix=${D}/usr/X11R6 sysconfdir=${D}/etc/X11/imlib install
  preplib /usr/X11R6
  dodoc AUTHORS COPYING* ChangeLog README
  dodoc NEWS
  docinto html
  dodoc doc/*.gif doc/index.html
}



