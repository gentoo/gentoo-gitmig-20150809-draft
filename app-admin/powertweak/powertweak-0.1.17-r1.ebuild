# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/powertweak/powertweak-0.1.17-r1.ebuild,v 1.6 2002/07/11 06:30:09 drobbins Exp $


S=${WORKDIR}/${P}
DESCRIPTION="Powertweak"
SRC_URI="http://powertweak.sourceforge.net/files/${P}.tar.bz2"
HOMEPAGE="http://powertweak.sourceforge.net"
LICENSE="GPL-2"

DEPEND="=x11-libs/gtk+-1.2*
	>=dev-libs/libxml-1.8.10"

src_compile() {
  cd ${S}                           
  try ./configure --host=${CHOST} --prefix=/usr
  try make
}

src_install() {
  cd ${S}
  try make install prefix=${D}/usr
  dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
  docinto Documentation
  dodoc Documentation/* 
}

