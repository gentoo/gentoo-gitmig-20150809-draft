# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/bonobo/bonobo-0.15.ebuild,v 1.2 2000/08/16 04:38:01 drobbins Exp $

P=bonobo-0.15
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A set of language and system independant CORBA interfaces"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/bonobo/"${A}
HOMEPAGE="http://www.gnome.org/"

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/opt/gnome --with-catgets
  make
}

src_install() {                               
  cd ${S}
  make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING* ChangeLog README
  dodoc NEWS TODO
}






