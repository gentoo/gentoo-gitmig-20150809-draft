# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/usbview/usbview-0.8.1-r1.ebuild,v 1.1 2000/08/06 13:36:58 achim Exp $

P=usbview-0.8.1
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="app-admin"
DESCRIPTION="Display the topology of devices on the USB bus"
SRC_URI="http://www.kroah.com/linux-usb/"${A}
HOMEPAGE="http://www.kroah.com/linux-usb/"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  ./configure --host=${CHOST} --prefix=/usr/X11R6 --with-catgets
  make
}

src_install() {                               
  cd ${S}
  make DESTDIR=${D} install
  dodoc AUTHORS ChangeLog COPYING NEWS README TODO
}




