# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rt73-firmware/rt73-firmware-1.8-r1.ebuild,v 1.2 2009/11/09 13:54:36 maekke Exp $

inherit multilib

MY_PN="RT71W_Firmware"
MY_P="${MY_PN}_V${PV}"

DESCRIPTION="Firmware for Ralink rt73-based WiFi USB adapters (rt73usb module)"
HOMEPAGE="http://www.ralinktech.com/ralink/Home/Support/Linux.html"
SRC_URI="http://www.ralinktech.com.tw/data/${MY_P}.zip"

LICENSE="ralink-firmware"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="|| ( sys-fs/udev
		sys-apps/hotplug )"

S="${WORKDIR}/${MY_P}"

src_install() {
	insinto /$(get_libdir)/firmware
	doins rt73.bin
	# The license MUST be installed so that we can redistribute.
	# Otherwise binpkgs or CDs wouldn't have the license.
	dodoc LICENSE.ralink-firmware.txt
}
