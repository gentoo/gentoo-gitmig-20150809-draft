# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <micke@hallendal.net>
# $Header: /var/cvsroot/gentoo-x86/dev-python/bonobo-python/bonobo-python-0.2.0.ebuild,v 1.1 2001/08/22 19:18:30 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Bonobo bindings for Python"
SRC_URI="http://theta.lajnux.nu/bonobo-python/download/${A}"
HOMEPAGE="http://theta.lajnux.nu/bonobo-python/"

DEPEND=">=x11-libs/gtk+-1.2.6
	>=gnome-base/bonobo-1.0.0
	>=dev-python/gnome-python-1.3.1
	>=dev-python/orbit-python-0.3.0
	virtual/python"

src_compile() {
  PYTHON="/usr/bin/python" try ./configure --host=${CHOST} --prefix=/usr  \
	--with-libIDL-prefix=/opt/gnome --with-orbit-prefix=/opt/gnome 	  \
	--with-oaf-prefix=/opt/gnome
  try make
}

src_install() {
  try make DESTDIR=${D} install
  dodoc AUTHORS COPYING ChangeLog NEWS
  dodoc README TODO
}




