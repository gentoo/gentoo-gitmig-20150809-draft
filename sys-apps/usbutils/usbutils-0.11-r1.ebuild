# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usbutils/usbutils-0.11-r1.ebuild,v 1.1 2003/06/04 20:46:59 hanno Exp $

S=${WORKDIR}/${P}
DESCRIPTION="USB enumeration utilities"
SRC_URI="http://usb.cs.tum.edu/download/usbutils/${P}.tar.gz"
HOMEPAGE="http://usb.cs.tum.edu/"
KEYWORDS="~x86 ~ppc ~sparc ~hppa"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_unpack() {
 	unpack ${A}
	cd ${P}
	mv usb.ids usb.ids.orig
	wget http://www.linux-usb.org/usb.ids
	if [ ! -f usb.ids ] ; then mv usb.ids.orig usb.ids ; fi
}

src_compile() {
	# put usb.ids in same place as pci.ids (/usr/share/misc)
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--datadir=/usr/share/misc || die "./configure failed"

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
