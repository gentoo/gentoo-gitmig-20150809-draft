# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libusb/libusb-0.1.5.ebuild,v 1.1 2002/03/11 23:46:50 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Userspace access to USB devices"
SRC_URI="http://prdownloads.sourceforge.net/libusb/${P}.tar.gz"
HOMEPAGE="http://libusb.sourceforge.net"

DEPEND="virtual/glibc"

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr || die

	make || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS NEWS README
}

