# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libusb/libusb-0.1.3b.ebuild,v 1.1 2001/06/05 19:43:20 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Userspace access to USB devices"
SRC_URI="http://prdownloads.sourceforge.net/libusb/${A}"
HOMEPAGE="http://libusb.sourceforge.net"

DEPEND="virtual/glibc"

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS NEWS README
}

