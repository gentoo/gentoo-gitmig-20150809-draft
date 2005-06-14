# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/orinoco-usb-firmware/orinoco-usb-firmware-0.1.ebuild,v 1.1 2005/06/14 19:13:46 brix Exp $

inherit rpm

S=${WORKDIR}

DESCRIPTION="Firmware for ORiNOCO USB IEEE 802.11 wireless LAN driver"

HOMEPAGE="http://folk.uio.no/oeysteio/orinoco-usb/"
SRC_URI="http://folk.uio.no/oeysteio/orinoco-usb/RPMS/${PN}.noarch.rpm"

LICENSE="Avaya"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND=">=sys-apps/hotplug-20040923"

src_install() {
	insinto /lib/firmware
	doins ${S}/usr/lib/hotplug/firmware/orinoco_ezusb_fw
}
