# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/usbview/usbview-0.9.0.ebuild,v 1.3 2000/11/02 02:17:12 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Display the topology of devices on the USB bus"
SRC_URI="http://www.kroah.com/linux-usb/"${A}
HOMEPAGE="http://www.kroah.com/linux-usb/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=dev-libs/glib-1.2.8
	>=x11-libs/gtk+-1.2.8
	>=x11-base/xfree-4.0.1"

src_unpack() {
  unpack ${A}
}

src_compile() {                           
  cd ${S}
  try ./configure --host=${CHOST} --prefix=/usr/X11R6 --with-catgets
  try make
}

src_install() {                               
  cd ${S}
  try make DESTDIR=${D} install
  dodoc AUTHORS ChangeLog COPYING NEWS README TODO
}





