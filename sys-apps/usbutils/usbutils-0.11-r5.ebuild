# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usbutils/usbutils-0.11-r5.ebuild,v 1.3 2004/11/20 06:40:08 dragonheart Exp $

inherit eutils gnuconfig

# note: update these regularly from http://www.linux-usb.org/usb.ids
#       and upload to gentoo mirrors - <liquidx@gentoo.org>
USB_IDS_VER="20040902"

DESCRIPTION="USB enumeration utilities"
SRC_URI="http://usb.cs.tum.edu/download/usbutils/${P}.tar.gz
	mirror://gentoo/usb.ids-${USB_IDS_VER}.gz"
HOMEPAGE="http://usb.cs.tum.edu/"

KEYWORDS="~x86 ~amd64 ppc ~sparc ~hppa ~alpha ~ia64 ~ppc64 mips"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	gnuconfig_update

	# replace usb.ids with an updated version
	mv ${WORKDIR}/usb.ids-${USB_IDS_VER} ${S}/usb.ids || die "unable to replace usb.ids"

	use ppc64 && ( cd ${S}; epatch ${FILESDIR}/0.11/ppc64-usbutils-kheaderfix.patch )

	# Fix endian-issues
	( cd "${S}" && epatch "${FILESDIR}/0.11/lsusb-endian.patch" )

	epatch ${FILESDIR}/usbutils-0.11-fix-usb-ids-man-page-ref.patch	#bug #62786
}

src_compile() {
	# put usb.ids in same place as pci.ids (/usr/share/misc)
	econf \
		--datadir=/usr/share/misc || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	# we don't need libusb.* from usbutils because it conflicts
	# with dev-libs/libusb
	rm -rf ${D}/usr/lib
	rm -rf ${D}/usr/include
}
