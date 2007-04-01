# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usbutils/usbutils-0.72-r3.ebuild,v 1.1 2007/04/01 00:22:14 robbat2 Exp $

inherit eutils

DESCRIPTION="USB enumeration utilities"
HOMEPAGE="http://linux-usb.sourceforge.net/"
SRC_URI="mirror://sourceforge/linux-usb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-libs/libusb"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-update-usbids.patch

	# put usb.ids in same place as pci.ids (/usr/share/misc)
	sed -i \
		-e 's:/usr/share/usb.ids:/usr/share/misc/usb.ids:' \
		lsusb.8 || die "sed lsusb.8"
	sed -e '/^DEST=/s:=usb.ids:=/usr/share/misc/usb.ids:' \
		update-usbids.sh > update-usbids
}

src_compile() {
	econf \
		--datadir=/usr/share/misc \
		--enable-usbmodules \
		|| die "./configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dosbin update-usbids || die "update-usbids failed"
	dodoc AUTHORS ChangeLog NEWS README

	exeinto /etc/cron.monthly
	newexe "${FILESDIR}"/usbutils.cron update-usbids || die
}
