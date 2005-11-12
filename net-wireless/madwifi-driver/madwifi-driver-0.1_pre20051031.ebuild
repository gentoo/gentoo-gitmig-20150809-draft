# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/madwifi-driver/madwifi-driver-0.1_pre20051031.ebuild,v 1.2 2005/11/12 23:23:59 genstef Exp $

inherit linux-mod

MADWIFI_SVN_REV="1227"
DESCRIPTION="Wireless driver for Atheros chipset a/b/g cards"
HOMEPAGE="http://www.madwifi.org"
SRC_URI="http://snapshots.madwifi.org/madwifi-trunk-r${MADWIFI_SVN_REV}-${PV:7:8}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
DEPEND="app-arch/sharutils"
RDEPEND=">=net-wireless/madwifi-tools-0.1_pre20051031"
S=${WORKDIR}/madwifi-trunk-r${MADWIFI_SVN_REV}-${PV:7:8}
CONFIG_CHECK="NET_RADIO"
ERROR_NET_RADIO="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."

pkg_setup() {
	linux-mod_pkg_setup

	use x86 && TARGET=i386-elf
	use amd64 && TARGET=x86_64-elf
	use ppc && TARGET=powerpc-be-eabi
	MODULE_NAMES="ath_hal(net:${S}/ath_hal)	wlan(net:${S}/net80211) wlan_acl(net:${S}/net80211)
		wlan_ccmp(net:${S}/net80211) wlan_tkip(net:${S}/net80211) wlan_wep(net:${S}/net80211)
		wlan_xauth(net:${S}/net80211) wlan_scan_sta(net:${S}/net80211) wlan_scan_ap(net:${S}/net80211)
		ath_rate_onoe(net:${S}/ath_rate/onoe)
		ath_rate_sample(net:${S}/ath_rate/sample) ath_pci(net:${S}/ath)"
	#	does not compile ath_rate_amrr(net:${S}/ath_rate/amrr)
	BUILD_PARAMS="KERNELPATH=${ROOT}${KV_OUT_DIR} KERNELRELEASE=${KV_FULL}
		TARGET=${TARGET} TOOLPREFIX=/usr/bin/"
	BUILD_TARGETS="all"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	for dir in ath ath_hal net80211 ath_rate/amrr ath_rate/onoe ath_rate/sample; do
		convert_to_m ${S}/${dir}/Makefile
	done

	# Fix for erronously included header
	sed -i "s:.*if.h>::" ${S}/net80211/ieee80211_ioctl.h || die
}

src_install() {
	linux-mod_src_install

	dodoc README COPYRIGHT docs/users-guide.pdf docs/WEP-HOWTO.txt

	# install headers for use by
	# net-wireless/wpa_supplicant and net-wireless/hostapd
	insinto /usr/include/madwifi/include/
	doins include/*.h
	insinto /usr/include/madwifi/net80211
	doins net80211/*.h
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo ""
	einfo "You need to create athX using wlanconfig"
	einfo "Baselayout will do that with the following in /etc/conf.d/net:"
	cat <<EOF
preup() {
	if [ "${IFACE}" = "ath0" ]; then
		/sbin/wlanconfig ath0 create wlandev wifi0 wlanmode sta
		return $?
	fi
}
 
postdown() {
	if [ "${IFACE}" = "ath0" ]; then
		/sbin/wlanconfig ath0 destroy
		return $?
	fi
}
EOF
}
