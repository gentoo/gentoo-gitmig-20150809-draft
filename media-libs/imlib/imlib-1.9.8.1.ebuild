# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/imlib/imlib-1.9.8.1.ebuild,v 1.1 2000/08/14 15:37:06 achim Exp $

P=imlib-1.9.8.1
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="media-libs"
DESCRIPTION="imlib"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/imlib/"${A}
HOMEPAGE="http://www.gnome.org/"

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/usr/X11R6 --sysconfdir=/etc/X11/imlib
  make
}

src_install() {                               
  cd ${S}
  make prefix=${D}/usr/X11R6 sysconfdir=${D}/etc/X11/imlib install
  dodoc AUTHORS COPYING* ChangeLog README
  dodoc NEWS
  docinto html
  dodoc doc/*.gif doc/index.html
}




