# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/madwifi-old/madwifi-old-0.0.1417.20060128.ebuild,v 1.3 2007/08/29 18:54:05 genstef Exp $

inherit linux-mod eutils

MY_P=${PN}-r${PV:4:4}-${PV:9:10}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Driver for Atheros based IEEE 802.11a/b/g wireless LAN cards"
HOMEPAGE="http://www.madwifi.org/"
SRC_URI="http://snapshots.madwifi.org/madwifi-old/${MY_P}.tar.gz"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="amrr onoe"
DEPEND="app-arch/sharutils"
RDEPEND="!net-wireless/madwifi-ng
		>=net-wireless/madwifi-old-tools-${PV}"

CONFIG_CHECK="CRYPTO WIRELESS_EXT SYSCTL"
ERROR_CRYPTO="${P} requires Cryptographic API support (CONFIG_CRYPTO)."
ERROR_WIRELESS_EXT="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_WIRELESS_EXT)."
ERROR_SYSCTL="${P} requires Sysctl support (CONFIG_SYSCTL)."
BUILD_TARGETS="all"
MODULESD_ATH_PCI_DOCS="README"

pkg_setup() {
	linux-mod_pkg_setup

	use x86 && TARGET=i386-elf
	use amd64 && TARGET=x86_64-elf
	use ppc && TARGET=powerpc-be-eabi

	MODULE_NAMES="ath_hal(net:${S}/ath_hal)
				wlan(net:${S}/net80211)
				wlan_acl(net:${S}/net80211)
				wlan_ccmp(net:${S}/net80211)
				wlan_tkip(net:${S}/net80211)
				wlan_wep(net:${S}/net80211)
				wlan_xauth(net:${S}/net80211)"

	BUILD_PARAMS="KERNELPATH=${KV_OUT_DIR}"

	if use amrr && use onoe; then
		eerror
		eerror "USE=\"amrr onoe\" is invalid, you can only specify one at a time."
		eerror
		die "USE=\"amrr onoe\" is invalid"
	fi

	if use amrr; then
		MODULE_NAMES="${MODULE_NAMES} ath_rate_amrr(net:${S}/ath_rate/amrr)"
		BUILD_PARAMS="${BUILD_PARAMS} ATH_RATE=ath_rate/amrr"
	elif use onoe; then
		MODULE_NAMES="${MODULE_NAMES} ath_rate_onoe(net:${S}/ath_rate/onoe)"
		BUILD_PARAMS="${BUILD_PARAMS} ATH_RATE=ath_rate/onoe"
	else
		MODULE_NAMES="${MODULE_NAMES} ath_rate_sample(net:${S}/ath_rate/sample)"
		BUILD_PARAMS="${BUILD_PARAMS} ATH_RATE=ath_rate/sample"
	fi

	MODULE_NAMES="${MODULE_NAMES} ath_pci(net:${S}/ath)"
}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/2.6.20.patch
	for dir in ath ath_hal net80211 ath_rate/amrr ath_rate/onoe ath_rate/sample; do
		convert_to_m ${S}/${dir}/Makefile
	done
}

src_compile() {
	ARCH=$(tc-arch-kernel)
	# assists in debugging
	emake KERNELPATH=${KV_OUT_DIR} info || die "emake info failed"

	linux-mod_src_compile
	ARCH=$(tc-arch)
}

src_install() {
	linux-mod_src_install

	dodoc README TODO SNAPSHOT

	# install headers for use by
	# net-wireless/wpa_supplicant and net-wireless/hostapd
	insinto /usr/include/madwifi/include/
	doins include/*.h
	insinto /usr/include/madwifi/net80211
	doins net80211/*.h
}

pkg_postinst() {
	local moddir="${ROOT}/lib/modules/${KV_FULL}/net/"

	einfo "Removing old ath_rate modules"
	if use amrr; then
		[[ -f "${moddir}/ath_rate_onoe.${KV_OBJ}" ]] && rm "${moddir}/ath_rate_onoe.${KV_OBJ}"
		[[ -f "${moddir}/ath_rate_sample.${KV_OBJ}" ]] && rm "${moddir}/ath_rate_sample.${KV_OBJ}"
	elif use onoe; then
		[[ -f "${moddir}/ath_rate_amrr.${KV_OBJ}" ]] && rm "${moddir}/ath_rate_amrr.${KV_OBJ}"
		[[ -f "${moddir}/ath_rate_sample.${KV_OBJ}" ]] && rm "${moddir}/ath_rate_sample.${KV_OBJ}"
	else
		[[ -f "${moddir}/ath_rate_amrr.${KV_OBJ}" ]] && rm "${moddir}/ath_rate_amrr.${KV_OBJ}"
		[[ -f "${moddir}/ath_rate_onoe.${KV_OBJ}" ]] && rm "${moddir}/ath_rate_onoe.${KV_OBJ}"
	fi

	linux-mod_pkg_postinst

	einfo
	einfo "If you use net-wireless/wpa_supplicant or net-wireless/hostapd with madwifi"
	einfo "you should remerge them now."
	einfo
}
