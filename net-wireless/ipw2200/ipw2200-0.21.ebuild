# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ipw2200/ipw2200-0.21.ebuild,v 1.1 2005/01/18 10:45:36 brix Exp $

inherit linux-mod

FW_VERSION="2.2"

DESCRIPTION="Driver for the Intel PRO/Wireless 2200BG/2915ABG miniPCI adapter"

HOMEPAGE="http://ipw2200.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
RDEPEND="=net-wireless/ipw2200-firmware-${FW_VERSION}
		net-wireless/wireless-tools
		!net-wireless/ipw2100"

BUILD_PARAMS="KSRC=${KV_DIR}"
BUILD_TARGETS="all"

MODULE_NAMES="ipw2200(net:)
			ieee80211(net:)
			ieee80211_crypt(net:)
			ieee80211_crypt_wep(net:)"
MODULESD_IPW2200_DOCS="README.ipw2200"

CONFIG_CHECK="NET_RADIO CRYPTO_ARC4 FW_LOADER CRC32"
NET_RADIO_ERROR="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."
CRYPTO_ARC4_ERROR="${P} requires support for ARC4 cipher algorithm (CONFIG_CRYPTO_ARC4)."
FW_LOADER_ERROR="${P} requires Hotplug firmware loading support (CONFIG_FW_LOADER)."
CRC32_ERROR="${P} requires support for CRC32 functions (CONFIG_CRC32)."

src_unpack() {
	unpack ${A}

	convert_to_m ${S}/Makefile
}

src_install() {
	linux-mod_src_install

	dodoc ISSUES CHANGES
}
