# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/zd1201/zd1201-0.14.ebuild,v 1.2 2006/09/17 18:32:32 jhuebel Exp $

inherit linux-mod

DESCRIPTION="Linux Driver for ZyDAS 1201 (zd1201) based USB 802.11b Network WiFi devices"

S=${WORKDIR}
FW_VERSION="${PV}"
HOMEPAGE="http://linux-lc100020.sourceforge.net/"
SRC_URI="mirror://sourceforge/linux-lc100020/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
RDEPEND="=net-wireless/zd1201-firmware-${FW_VERSION}
		net-wireless/wireless-tools"

MODULE_NAMES="zd1201(net:)"
BUILD_TARGETS="clean modules"

CONFIG_CHECK="NET_RADIO USB FW_LOADER"
NET_RADIO_ERROR="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."
USB_ERROR="$P requires USB support (CONFIG_USB)"
FW_LOADER_ERROR="${P} requires Hotplug firmware loading support (CONFIG_FW_LOADER)."

pkg_setup() {
	if kernel_is lt 2 6 10; then
		die "Please upgrade to kernel 2.6.10 or above. There is a USB issue with anything lower."
	fi

	linux-mod_pkg_setup
	BUILD_PARAMS="KERNEL_SOURCE=${KV_DIR} KERNEL_VERSION=${KV_MAJOR}.${KV_MINOR}"
}

src_install() {
	linux-mod_src_install

	dodoc README
}
