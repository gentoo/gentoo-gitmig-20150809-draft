# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libusb/libusb-0.1.5.ebuild,v 1.5 2002/08/14 11:52:27 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Userspace access to USB devices"
SRC_URI="mirror://sourceforge/libusb/${P}.tar.gz"
HOMEPAGE="http://libusb.sourceforge.net"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	econf || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS NEWS README
}
