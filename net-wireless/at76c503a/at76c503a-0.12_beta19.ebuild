# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/at76c503a/at76c503a-0.12_beta19.ebuild,v 1.2 2005/03/24 20:11:10 blubb Exp $

inherit linux-mod eutils

MY_P=${PN}_${PV/_beta/.beta}
SRC_PATCH="${MY_P}-4.diff"
DESCRIPTION="at76c503 is a Linux driver for the wlan USB adapter based on the Atmel at76c503 chip. It currently supports ad-hoc mode, infrastructure mode, and WEP. It supports adapters from Atmel, the Belkin F5D6050, Netgear MA101, and others."
HOMEPAGE="http://at76c503a.berlios.de"
SRC_URI="mirror://debian/pool/contrib/a/at76c503a/${MY_P}.orig.tar.gz
		mirror://debian/pool/contrib/a/at76c503a/${SRC_PATCH}.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND="net-wireless/atmel-firmware
		>=sys-apps/hotplug-20040923
		>=net-wireless/wireless-tools-26-r1"
S=${WORKDIR}/${MY_P/_/-}.orig

MODULE_NAMES="at76_usbdfu(net:) at76c503-i3861(net:) at76c503-i3863(net:)
	at76c503-rfmd-acc(net:) at76c503-rfmd(net:) at76c503(net:) at76c505-rfmd(net:)
	at76c505-rfmd2958(net:) at76c505a-rfmd2958(net:)"
BUILD_PARAMS="KSRC=${KV_DIR}"
BUILD_TARGETS="all"

CONFIG_CHECK="NET_RADIO"
NET_RADIO_ERROR="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${SRC_PATCH}
	convert_to_m Makefile
	sed -si "s:-cp \$(KERNEL_SRC)/.tmp_versions/\*.mod \$(MODVERDIR)::" Makefile
}

src_install() {
	linux-mod_src_install

	dodoc README COPYING CHANGELOG
}
