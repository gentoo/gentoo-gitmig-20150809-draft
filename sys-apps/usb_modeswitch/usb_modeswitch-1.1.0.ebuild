# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usb_modeswitch/usb_modeswitch-1.1.0.ebuild,v 1.1 2010/02/21 18:28:48 robbat2 Exp $

inherit multilib

MY_PN="${PN/_/-}"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="USB_ModeSwitch is a tool for controlling 'flip flop' (multiple devices) USB gear like UMTS sticks."
HOMEPAGE="http://www.draisberghof.de/usb_modeswitch/"
SRC_URI="http://www.draisberghof.de/usb_modeswitch/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="=virtual/libusb-0*"
RDEPEND="${DEPEND}
		 dev-lang/tcl"
# TCL rdep is not an error. The runner script is written in it.

S="${WORKDIR}/${MY_P}"

src_install() {
	UDEVDIR="/$(get_libdir)/udev/"
	dodir "${UDEVDIR}" /usr/share/man/man1 "${UDEVDIR}"/rules.d /etc/udev/rules.d/
	emake files-install DESTDIR="${D}" UDEVDIR="${D}/${UDEVDIR}"
	insinto /etc/udev/rules.d/
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
