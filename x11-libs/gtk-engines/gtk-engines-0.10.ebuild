# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk-engines/gtk-engines-0.10.ebuild,v 1.3 2000/09/15 20:09:29 drobbins Exp $

P=gtk-engines-0.10
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gtk-engines"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gtk-engines/"${A}
HOMEPAGE="http://www.gnome.org/"

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr/X11R6
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/usr/X11R6 install
  dodoc AUTHORS COPYING* ChangeLog README NEWS
}




