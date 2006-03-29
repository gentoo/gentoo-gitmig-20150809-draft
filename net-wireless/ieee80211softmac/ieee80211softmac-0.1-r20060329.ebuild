# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ieee80211softmac/ieee80211softmac-0.1-r20060329.ebuild,v 1.1 2006/03/29 23:49:35 josejx Exp $

inherit linux-mod

DESCRIPTION="Software MAC and the updated generic IEEE 802.11 network subsystem"
HOMEPAGE="http://softmac.sipsolutions.net"
SRC_URI="mirror://gentoo/${PN}-${PR#r}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="!net-wireless/ieee80211
	|| ( >=sys-kernel/gentoo-sources-2.6.15 \
		>=sys-kernel/vanilla-sources-2.6.15 \
		>=sys-kernel/suspend2-sources-2.6.15 )"
RDEPEND="${DEPEND}"

IUSE=""
BUILD_TARGETS="modules"
MODULE_NAMES="ieee80211(net/ieee80211::net/ieee80211) \
	ieee80211_crypt(net/ieee80211::net/ieee80211) \
	ieee80211_crypt_ccmp(net/ieee80211::net/ieee80211) \
	ieee80211_crypt_tkip(net/ieee80211::net/ieee80211) \
	ieee80211_crypt_wep(net/ieee80211::net/ieee80211) \
	ieee80211softmac(net/ieee80211::net/ieee80211/softmac)"

CONFIG_CHECK="NET_RADIO !IEEE80211"
ERROR_NET_RADIO="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."
ERROR_IEEE80211="${P} requires that you disable the in-kernel version of the IEEE802.11 subsystem (CONFIG_IEEE80211)."

S="${WORKDIR}/softmac-snapshot"

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is lt 2 6 15; then
		die "${P} requires kernel 2.6.15 or newer, sorry."
	fi

	BUILD_PARAMS="KSRC=${KV_DIR} KSRC_OUTPUT=${KV_OUT_DIR} \
		KDIR=${ROOT}/lib/modules/${KV_FULL}/build"
}

src_install() {
	linux-mod_src_install

	insinto /usr/include/softmac/net
	doins include/net/*.h
}
