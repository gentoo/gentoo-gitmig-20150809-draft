# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ieee80211/ieee80211-1.0.3.ebuild,v 1.3 2005/08/16 12:30:29 brix Exp $

inherit linux-mod

# The following works with both pre-releases and releases
MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Generic IEEE 802.11 network subsystem for Linux"
HOMEPAGE="http://ieee80211.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"

DEPEND="!<=net-wireless/ipw2100-1.1.0
		!<=net-wireless/ipw2200-1.0.4"
RDEPEND="${DEPEND}"

IUSE="debug"
BUILD_TARGETS="all"
MODULE_NAMES="ieee80211(net/ieee80211:)
			ieee80211_crypt(net/ieee80211:)
			ieee80211_crypt_wep(net/ieee80211:)
			ieee80211_crypt_ccmp(net/ieee80211:)
			ieee80211_crypt_tkip(net/ieee80211:)"

CONFIG_CHECK="NET_RADIO CRYPTO_ARC4 CRYPTO_MICHAEL_MIC CRC32"
ERROR_NET_RADIO="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."
ERROR_CRYPTO_ARC4="${P} requires support for ARC4 cipher algorithm (CONFIG_CRYPTO_ARC4)."
ERROR_CRYPTO_MICHAEL_MIC="${P} requires support for Michael MIC keyed digest algorithm (CONFIG_CRYPTO_MICHAEL_MIC)."
ERROR_CRC32="${P} requires support for CRC32 functions (CONFIG_CRC32)."

pkg_setup() {
	if kernel_is 2 4; then
		die "${P} does not support building against kernel 2.4.x"
	fi

	if ! (linux_chkconfig_present CRYPTO_AES_586 || linux_chkconfig_present CRYPTO_AES); then
		eerror "${P} requires support for AES cipher algorithms (i586) (CONFIG_CRYPTO_AES_586)."
		eerror "This option is called CONFIG_CRYPTO_AES in kernels prior to 2.6.8."
		die "CONFIG_CRYPTO_AES_586 support not detected"
	fi

	linux-mod_pkg_setup

	BUILD_PARAMS="KSRC=${KV_DIR} KSRC_OUTPUT=${KV_OUT_DIR}"
}

src_unpack() {
	local debug="n"

	unpack ${A}

	use debug && debug="y"
	sed -i -e "s:^\(CONFIG_IEEE80211_DEBUG\)=.*:\1=${debug}:" ${S}/Makefile
}

src_install() {
	linux-mod_src_install

	insinto /usr/include/net
	doins net/*

	dodoc CHANGES
}
