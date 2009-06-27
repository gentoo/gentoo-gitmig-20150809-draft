# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usb_modeswitch/usb_modeswitch-1.0.2.ebuild,v 1.1 2009/06/27 12:25:16 hanno Exp $

inherit toolchain-funcs

DESCRIPTION="USB_ModeSwitch is a tool for controlling 'flip flop' (multiple devices) USB gear like UMTS sticks."
HOMEPAGE="http://www.draisberghof.de/usb_modeswitch/"
SRC_URI="http://www.draisberghof.de/usb_modeswitch/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/libusb"
RDEPEND="${DEPEND}"

src_compile() {
	$(tc-getCC) ${CPPFLAGS} ${CFLAGS} ${LDFLAGS} -o usb_modeswitch usb_modeswitch.c -lusb \
		|| die 'failed to compile usb_modeswitch'
}

src_install() {
	dosbin usb_modeswitch
	insinto /etc
	doins usb_modeswitch.conf
	insinto /etc/udev/rules.d
	newins "${FILESDIR}"/91-usb_modeswitch.rules.udev-ge-106 \
		91-usb_modeswitch.rules
}

pkg_postinst() {
	einfo 'For automated mode switching via udev, use "lsusb"'
	einfo 'to find the correct values for your device and modify'
	einfo 'them in /etc/udev/rules.d/91-usb_modeswitch.rules'
	einfo
	einfo 'You should also read the documentation on'
	einfo "${HOMEPAGE}"
}
