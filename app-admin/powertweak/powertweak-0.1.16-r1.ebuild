# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/powertweak/powertweak-0.1.16-r1.ebuild,v 1.1 2000/08/06 13:36:58 achim Exp $

P=powertweak-0.1.16
A=${P}.tar.bz2
S=${WORKDIR}/${P}
CATEGORY="app-admin"
DESCRIPTION="Powertweak"
SRC_URI="http://powertweak.soureforge.net/files/"${A}
HOMEPAGE="http://powertweak.soureforge.net"


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



