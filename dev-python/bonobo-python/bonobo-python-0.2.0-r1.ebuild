# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <micke@hallendal.net>
# $Header: /var/cvsroot/gentoo-x86/dev-python/bonobo-python/bonobo-python-0.2.0-r1.ebuild,v 1.1 2001/10/06 11:24:06 azarah Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Bonobo bindings for Python"
SRC_URI="http://theta.lajnux.nu/bonobo-python/download/${A}"
HOMEPAGE="http://theta.lajnux.nu/bonobo-python/"

DEPEND=">=x11-libs/gtk+-1.2.10-r4
	>=gnome-base/bonobo-1.0.9-r1
	>=dev-python/gnome-python-1.4.1-r2
	>=dev-python/orbit-python-0.3.0-r1
	virtual/python"

src_compile() {
  PYTHON="/usr/bin/python" try ./configure --host=${CHOST} --prefix=/usr  \
	--with-libIDL-prefix=/usr --with-orbit-prefix=/usr 	  \
	--with-oaf-prefix=/usr
  try make
}

src_install() {
  try make DESTDIR=${D} install
  dodoc AUTHORS COPYING ChangeLog NEWS
  dodoc README TODO
}




