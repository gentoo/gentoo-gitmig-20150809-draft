# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <micke@hallendal.net>
# $Header: /var/cvsroot/gentoo-x86/dev-python/orbit-python/orbit-python-0.2.0.ebuild,v 1.1 2001/07/02 19:48:59 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="ORBit bindings for Python"
SRC_URI="http://orbit-python.sault.org/${A}"
HOMEPAGE="http://orbit-python.sault.org/"

DEPEND=">=dev-libs/glib-1.1.4
	>=gnome-base/ORBit-0.5.1
	virtual/python"

src_compile() {
  PYTHON="/usr/bin/python" try ./configure --host=${CHOST} --prefix=/usr \
	--with-libIDL-prefix=/opt/gnome --with-orbit-prefix=/opt/gnome
  try make
}

src_install() {
  try make DESTDIR=${D} install
  dodoc AUTHORS COPYING ChangeLog NEWS
  dodoc README TODO
}




