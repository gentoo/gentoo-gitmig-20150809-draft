# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bcm43xx/bcm43xx-0.0.1-r20060105.ebuild,v 1.1 2006/01/05 22:44:38 kugelfang Exp $

inherit linux-mod

DESCRIPTION="Driver for Broadcom 43xx PCI/miniPCI based wireless network devices"
HOMEPAGE="http://bcm43xx.berlios.de"
SRC_URI="mirror://gentoo/${PN}-${PVR}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"

IUSE="debug"
DEPEND=""
RDEPEND="${DEPEND}
		net-wireless/ieee80211softmac
		>=net-wireless/wireless-tools-28_pre4"

BUILD_TARGETS="modules"
MODULE_NAMES="bcm43xx(net/wireless:)"

CONFIG_CHECK="NET_RADIO FW_LOADER"
ERROR_NET_RADIO="${P} requires support for \"Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)\"."
ERROR_FW_LOADER="${P} requires \"Hotplug firmware loading support (CONFIG_FW_LOADER)\"."
ERROR_IEEE80211="${P} requies (modular) support for \"Generic IEEE 802.11 Networking Stack\"."

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is 2 4; then
		die "${P} does not support building against kernel 2.4.x"
	fi
}

src_compile() {
	BUILD_PARAMS="KSRC=${KV_DIR} KSRC_OUTPUT=${KV_OUT_DIR} SOFTMAC_DIR=/usr/include" linux-mod_src_compile
}

pkg_postinst() {
	linux-mod_pkg_postinst

	if [ -f /lib/modules/${KV_FULL}/net/${PN}.ko ]; then
		einfo
		einfo "Modules from an earlier installation detected. You will need to manually"
		einfo "remove those modules by running the following commands:"
		einfo "  # rm -f /lib/modules/${KV_FULL}/net/${PN}.ko"
		einfo "  # rm -f /lib/modules/${KV_FULL}/net/ieee80211*.ko"
		einfo "  # depmod -a"
		einfo
	fi
}
