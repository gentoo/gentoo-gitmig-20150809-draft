# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/bonobo/bonobo-0.18.ebuild,v 1.4 2000/11/03 09:11:30 achim Exp $

P=bonobo-0.18
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A set of language and system independant CORBA interfaces"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/bonobo/"${A}
HOMEPAGE="http://www.gnome.org/"

DEPEND=">=gnome-base/oaf-0.5.1
	>=gnome-base/gnome-print-0.24"

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/opt/gnome --with-catgets
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING* ChangeLog README
  dodoc NEWS TODO
}






