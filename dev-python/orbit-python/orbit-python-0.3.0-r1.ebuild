# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <micke@hallendal.net>
# $Header: /var/cvsroot/gentoo-x86/dev-python/orbit-python/orbit-python-0.3.0-r1.ebuild,v 1.1 2001/10/06 11:24:06 azarah Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="ORBit bindings for Python"
SRC_URI="http://orbit-python.sault.org/files/${A}"
HOMEPAGE="http://orbit-python.sault.org/"

DEPEND=">=dev-libs/glib-1.2.10
	>=gnome-base/ORBit-0.5.10-r1
	virtual/python"

src_compile() {
  PYTHON="/usr/bin/python" try ./configure --host=${CHOST} --prefix=/usr \
	--with-libIDL-prefix=/usr --with-orbit-prefix=/usr
  try make
}

src_install() {
  try make DESTDIR=${D} install
  dodoc AUTHORS COPYING ChangeLog NEWS
  dodoc README TODO
}




