# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libusb/libusb-0.1.3b.ebuild,v 1.4 2002/07/11 06:30:21 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Userspace access to USB devices"
SRC_URI="mirror://sourceforge/libusb/${P}.tar.gz"
HOMEPAGE="http://libusb.sourceforge.net"

DEPEND="virtual/glibc"

src_compile() {
	./configure --host=${CHOST}					\
		    --prefix=/usr
	assert

	make || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS NEWS README
}
