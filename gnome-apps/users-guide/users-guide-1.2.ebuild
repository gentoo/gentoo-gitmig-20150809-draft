# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/users-guide/users-guide-1.2.ebuild,v 1.2 2000/08/16 04:38:01 drobbins Exp $

P=users-guide-1.2
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-users-guide"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/users-guide/"${A}
HOMEPAGE="http://www.gnome.org/"

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/opt/gnome
  make
}

src_install() {                               
  cd ${S}
  make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING* ChangeLog NEWS
  dodoc README* TODO
}



