# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-python/gnome-python-1.4.0.ebuild,v 1.1 2001/04/23 01:00:39 pete Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-python"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/latest/sources/"${A}
HOMEPAGE="http://www.gnome.org"

DEPEND=">=gnome-base/libglade-0.16
	>=gnome-base/gnome-core-1.4.0
	>=virtual/python-1.5.2"

src_compile() {                           
  cd ${S}
  PYTHON="/usr/bin/python" try ./configure --host=${CHOST} --prefix=/usr \
    --with-gnome --with-gtkhtml
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr install
  dodoc AUTHORS COPYING* ChangeLog NEWS
  dodoc README*
  cd ${S}/pygnome ; docinto pygnome
  dodoc COPYING
  cd ${S}/pygtk ; docinto pygtk
  dodoc AUTHORS COPYING ChangeLog MAPPING NEWS README
}




