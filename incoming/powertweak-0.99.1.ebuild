# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/app-admin/powerteak/powertweak-0.99.1.ebuild
# $Header: /var/cvsroot/gentoo-x86/incoming/powertweak-0.99.1.ebuild,v 1.3 2001/08/31 03:23:39 pm Exp $


A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Powertweak"
SRC_URI="http://download.sourceforge.net/powertweak/${A}"
HOMEPAGE="http://powertweak.sourceforge.net"

DEPEND=">=x11-libs/gtk+-1.2.8
	>=gnome-base/libxml-1.8.10"

src_compile() {
# fix minor bug in textmode/Makefile.am with no -L<path> to libxml.so
  sed -e "s:GPML = -lgpm:GPML = -L/opt/gnome/lib -lgpm:" < src/textmode/Makefile.am > src/textmode/Makefile.am_fix
  mv src/textmode/Makefile.am_fix src/textmode/Makefile.am
  ./autogen.sh

  try ./configure --host=${CHOST} --prefix=/usr/X11R6 --with-xml-prefix=/opt/gnome
  try make
}

src_install() {
  cd ${S}
  try make install prefix=${D}/usr/X11R6
  dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
  docinto Documentation
  dodoc Documentation/* 
}
