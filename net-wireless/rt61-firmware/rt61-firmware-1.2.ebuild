# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rt61-firmware/rt61-firmware-1.2.ebuild,v 1.2 2009/03/14 22:18:45 rbu Exp $

inherit multilib

MY_PN="RT61_Firmware"
MY_P="${MY_PN}_V${PV}"

DESCRIPTION="Firmware for Ralink rt61-based PCI/PCMCIA WiFi adapters (rt61pci module)"
HOMEPAGE="http://www.ralinktech.com/ralink/Home/Support/Linux.html"
SRC_URI="http://www.ralinktech.com.tw/data/${MY_P}.zip"

LICENSE="ralink-firmware"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="|| ( sys-fs/udev
		sys-apps/hotplug )"

S="${WORKDIR}/${MY_P}"

src_install() {
	insinto /$(get_libdir)/firmware
	doins *.bin
}
