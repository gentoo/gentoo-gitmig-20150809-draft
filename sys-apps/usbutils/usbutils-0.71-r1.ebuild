# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usbutils/usbutils-0.71-r1.ebuild,v 1.5 2006/02/16 14:06:29 gustavoz Exp $

inherit eutils

DESCRIPTION="USB enumeration utilities"
HOMEPAGE="http://linux-usb.sourceforge.net/"
SRC_URI="mirror://sourceforge/linux-usb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc64 ~s390 ~sh sparc x86"
IUSE=""

DEPEND="dev-libs/libusb"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# put usb.ids in same place as pci.ids (/usr/share/misc)
	sed -i \
		-e 's:/usr/share/usb.ids:/usr/share/misc/usb.ids:' \
		lsusb.8 || die "sed lsusb.8"
	sed -e '/^DEST=/s:=usb.ids:=/usr/share/misc/usb.ids:' \
		update-usbids.sh > update-usbids

	epatch "${FILESDIR}"/${P}-new-video-format.patch #111781

	# replace usb.ids with an updated version
	ebegin "Updating usb.ids"
	./update-usbids.sh &> /dev/null
	eend 0
}

src_compile() {
	econf \
		--datadir=/usr/share/misc \
		--enable-usbmodules \
		|| die "./configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dosbin update-usbids || die "update-usbids failed"
	dodoc AUTHORS ChangeLog NEWS README
}
