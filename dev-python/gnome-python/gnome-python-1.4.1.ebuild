# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-python/gnome-python-1.4.1.ebuild,v 1.4 2001/06/04 21:57:52 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-python"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/latest/sources/"${A}
HOMEPAGE="http://www.gnome.org"

DEPEND=">=gnome-base/gnome-core-1.4.0
        opengl? ( >=x11-libs/gtkglarea-1.2.2 )
	virtual/python"

src_compile() {
  PYTHON="/usr/bin/python" try ./configure --host=${CHOST} --prefix=/usr \
    --with-gnome
  try make
}

src_install() {
  try make prefix=${D}/usr install
  dodoc AUTHORS COPYING* ChangeLog NEWS
  dodoc README*
  cd ${S}/pygnome ; docinto pygnome
  dodoc COPYING
  cd ${S}/pygtk ; docinto pygtk
  dodoc AUTHORS COPYING ChangeLog MAPPING NEWS README
}




