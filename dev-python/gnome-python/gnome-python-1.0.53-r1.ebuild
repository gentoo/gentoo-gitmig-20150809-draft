# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-python/gnome-python-1.0.53-r1.ebuild,v 1.1 2000/08/07 18:59:45 achim Exp $

P=gnome-python-1.0.53
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-python"
DESCRIPTION="gnome-python"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/latest/sources/"${A}
HOMEPAGE="http://www.gnome.org"

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/usr
  make
}

src_install() {                               
  cd ${S}
  make prefix=${D}/usr install
  dodoc AUTHORS COPYING* ChangeLog INSTALL* NEWS
  dodoc README*
}




