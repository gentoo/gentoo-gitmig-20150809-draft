# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rtl8187/rtl8187-1.10.ebuild,v 1.4 2007/05/09 20:00:14 genstef Exp $

inherit eutils linux-mod

FILE="rtl8187_linux_26.1010.zip"

DESCRIPTION="Driver for the RTL8187 wireless chipset"
HOMEPAGE="http://www.realtek.com.tw"
SRC_URI="ftp://61.56.69.18/cn/wlan/${FILE}
	ftp://209.216.61.149/cn/wlan/${FILE}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="app-arch/unzip"

S=${WORKDIR}/rtl8187_linux_26.1010.0622.2006

MODULE_NAMES="ieee80211_crypt-rtl(net:${S}/ieee80211) ieee80211_crypt_wep-rtl(net:${S}/ieee80211)
	ieee80211_crypt_tkip-rtl(net:${S}/ieee80211) ieee80211_crypt_ccmp-rtl(net:${S}/ieee80211)
	ieee80211-rtl(net:${S}/ieee80211) r8187(net:${S}/beta-8187)"
BUILD_TARGETS=" "
MODULESD_R8187_ALIASES=("wlan0 r8187")

pkg_setup() {
	if ! kernel_is 2 6 ; then
		eerror "This driver is for kernel version 2.6 or greater only!"
		die "No kernel version 2.6 or greater detected!"
	fi

	linux-mod_pkg_setup

	# Needs NET_RADIO in kernel, for wireless_send_event
	local CONFIG_CHECK="NET_RADIO CRYPTO CRYPTO_ARC4 CRC32 !IEEE80211"
	local ERROR_IEEE80211="${P} requires the in-kernel version of the IEEE802.11 subsystem to be disabled (CONFIG_IEEE80211)"
	check_extra_config

	BUILD_PARAMS="KSRC=${KV_DIR}"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	unpack ./stack.tar.gz
	unpack ./drv.tar.gz

	edos2unix beta-8187/r8187_core.c || die
	edos2unix beta-8187/r8187.h || die

	cp -f ieee80211/readme ieee80211.txt
	rm -f beta-8187/*~

	epatch "${FILESDIR}/kernel-2.6.19.patch"

	einfo "Ignore the 'ieee80211* undefined' warnings."
}

src_install() {
	linux-mod_src_install

	dodoc *.txt wlan0* beta-8187/{authors,changes,readme}
}

pkg_postinst() {
	linux-mod_pkg_postinst

	elog "You may want to add the following modules to"
	elog "/etc/modules.autoload.d/kernel-2.6"
	elog
	elog "The module itself:       r8187"
	elog "WEP and WPA encryption:  ieee80211_crypt-rtl"
	elog "WEP encryption:          ieee80211_crypt_wep-rtl"
	elog "WPA TKIP encryption:     ieee80211_crypt_tkip-rtl"
	elog "WPA CCMP encryption:     ieee80211_crypt_ccmp-rtl"
	elog "For the r8187 module:    ieee80211-rtl"
}
