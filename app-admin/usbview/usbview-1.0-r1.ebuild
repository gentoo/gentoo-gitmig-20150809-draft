# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/usbview/usbview-1.0-r1.ebuild,v 1.6 2002/07/17 20:43:17 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Display the topology of devices on the USB bus"
SRC_URI="http://www.kroah.com/linux-usb/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.kroah.com/linux-usb/"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	=x11-libs/gtk+-1.2*"

src_compile() {

  try ./configure --host=${CHOST} --prefix=/usr
  try make

}

src_install() {

  try make DESTDIR=${D} install
  dodoc AUTHORS ChangeLog COPYING NEWS README TODO

}





