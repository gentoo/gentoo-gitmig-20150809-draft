# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gda lib"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnome-db/${A}"
HOMEPAGE="http://www.gnome.org/gnome-db"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/opt/gnome \
	--with-mysql=/usr --with-ldap=/usr --with-catgets
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install

  dodoc AUTHORS COPYING.* ChangeLog NEWS README THANKS TODO
}



