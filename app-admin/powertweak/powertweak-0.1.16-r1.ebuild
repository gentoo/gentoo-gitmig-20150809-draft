# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/powertweak/powertweak-0.1.16-r1.ebuild,v 1.4 2000/08/28 03:01:53 achim Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Powertweak"
SRC_URI="http://powertweak.sourceforge.net/files/"${A}
HOMEPAGE="http://powertweak.sourceforge.net"


src_compile() {
  cd ${S}                           
  ./configure --host=${CHOST} --prefix=/usr/X11R6
  make
}

src_install() {
  cd ${S}
  make install prefix=${D}/usr/X11R6
  dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
  docinto Documentation
  dodoc Documentation/* 
}





