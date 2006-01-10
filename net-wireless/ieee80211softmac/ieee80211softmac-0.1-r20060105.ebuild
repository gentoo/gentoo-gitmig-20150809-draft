# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ieee80211softmac/ieee80211softmac-0.1-r20060105.ebuild,v 1.2 2006/01/10 13:12:35 pylon Exp $

inherit linux-mod

DESCRIPTION="Software MAC for the generic IEEE 802.11 network subsystem"
HOMEPAGE="http://softmac.sipsolutions.net"
SRC_URI="mirror://gentoo/${PN}-${PVR}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"

DEPEND="!net-wireless/ieee80211
		|| ( >=gentoo-sources-2.6.15 >=vanilla-sources-2.6.15 )"
RDEPEND="${DEPEND}"

IUSE=""
BUILD_TARGETS="modules"
MODULE_NAMES="ieee80211softmac(net/ieee80211:)"

CONFIG_CHECK="NET_RADIO IEEE80211"
ERROR_NET_RADIO="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."
ERROR_IEEE80211="${P} requires the in-kernel version of the IEEE802.11 subsystem (CONFIG_IEEE80211)"

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is 2 4; then
		die "${P} does not support building against kernel 2.4.x"
	fi

	BUILD_PARAMS="KSRC=${KV_DIR} KSRC_OUTPUT=${KV_OUT_DIR}"
}

src_install() {
	linux-mod_src_install

	insinto /lib/modules/$(uname -r)/build/include/net/
	doins net/*.h
}
