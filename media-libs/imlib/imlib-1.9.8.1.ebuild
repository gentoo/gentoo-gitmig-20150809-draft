# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib/imlib-1.9.8.1.ebuild,v 1.5 2000/11/02 02:17:12 achim Exp $

P=imlib-1.9.8.1
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="imlib"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/imlib/"${A}
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3
	>=media-libs/giflib-4.1.0
	>=media-libs/libpng-1.0.7
	>=media-libs/tiff-3.5.5
	>=media-libs/jpeg-6b
	>=dev-libs/glib-1.2.8
	>=x11-libs/gtk+-1.2.8
	>=x11-base/xfree-4.0.1"

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr/X11R6 --sysconfdir=/etc/X11/imlib
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr/X11R6 sysconfdir=${D}/etc/X11/imlib install
  preplib /usr/X11R6
  dodoc AUTHORS COPYING* ChangeLog README
  dodoc NEWS
  docinto html
  dodoc doc/*.gif doc/index.html
}




