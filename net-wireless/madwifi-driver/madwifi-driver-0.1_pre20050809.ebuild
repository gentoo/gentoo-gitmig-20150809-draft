# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/madwifi-driver/madwifi-driver-0.1_pre20050809.ebuild,v 1.1 2005/08/10 12:44:19 genstef Exp $

inherit linux-mod

DESCRIPTION="Wireless driver for Atheros chipset a/b/g cards"
HOMEPAGE="http://madwifi.sourceforge.net/"
SRC_URI="http://madwifi.otaku42.de/${PV:7:4}/${PV:11:2}/madwifi-cvs-snapshot-${PV:7:4}-${PV:11:2}-${PV:13:2}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
DEPEND="app-arch/sharutils"
RDEPEND=""
S=${WORKDIR}/madwifi
CONFIG_CHECK="NET_RADIO"
ERROR_NET_RADIO="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."

pkg_setup() {
	linux-mod_pkg_setup

	use x86 && TARGET=i386-elf
	use amd64 && TARGET=x86_64-elf
	use ppc && TARGET=powerpc-be-eabi
	MODULE_NAMES="ath_hal(net:${S}/ath_hal)	wlan(net:${S}/net80211) wlan_acl(net:${S}/net80211)
		wlan_ccmp(net:${S}/net80211) wlan_tkip(net:${S}/net80211) wlan_wep(net:${S}/net80211)
		wlan_xauth(net:${S}/net80211) ath_rate_amrr(net:${S}/ath_rate/amrr)
		ath_rate_onoe(net:${S}/ath_rate/onoe)
		ath_rate_sample(net:${S}/ath_rate/sample) ath_pci(net:${S}/ath)"
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
}

src_install() {
	linux-mod_src_install

	dodoc README COPYRIGHT
}

pkg_postinst() {
	update_depmod
	update_modules

	einfo ""
	einfo "The madwifi drivers create an interface named 'athX'"
	einfo "Create /etc/init.d/net.ath0 and add a line for athX"
	einfo "in /etc/conf.d/net"
	einfo ""
}
