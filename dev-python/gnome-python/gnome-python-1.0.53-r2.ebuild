# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-python/gnome-python-1.0.53-r2.ebuild,v 1.1 2000/12/01 19:46:12 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-python"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/latest/sources/"${A}
HOMEPAGE="http://www.gnome.org"

DEPEND=">=gnome-base/libglade-0.14
	>=gnome-base/gnome-core-1.2.2.1
	>=virtual/python-1.5.2"

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr 
  # --with-gtkhtml does not work 
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr install
  dodoc AUTHORS COPYING* ChangeLog INSTALL* NEWS
  dodoc README*
}




