# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/app-admin/powertweak/powertweak-0.1.17.ebuild,v 1.1 2000/11/26 20:54:15 achim Exp
# $Header: /var/cvsroot/gentoo-x86/app-admin/powertweak/powertweak-0.1.17.ebuild,v 1.3 2001/08/30 17:31:35 pm Exp $


A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Powertweak"
SRC_URI="http://powertweak.sourceforge.net/files/"${A}
HOMEPAGE="http://powertweak.sourceforge.net"

DEPEND=">=x11-libs/gtk+-1.2.8
	>=gnome-base/libxml-1.8.10"

src_compile() {
  cd ${S}                           
  try ./configure --host=${CHOST} --prefix=/usr/X11R6
  try make
}

src_install() {
  cd ${S}
  try make install prefix=${D}/usr/X11R6
  dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
  docinto Documentation
  dodoc Documentation/* 
}





