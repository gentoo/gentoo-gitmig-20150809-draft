# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ipw2200/ipw2200-0.7.ebuild,v 1.1 2004/09/04 21:11:03 jbms Exp $

inherit kernel-mod eutils

FW_VERSION="2.0"

DESCRIPTION="Driver for the Intel PRO/Wireless 2200BG miniPCI adapter"

HOMEPAGE="http://ipw2200.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz
		mirror://gentoo/${PN}-fw-${FW_VERSION}.tgz"

LICENSE="GPL-2 ipw2200-fw"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

# net-wireless/ipw2100 builds a possibly incompatible ieee80211
# module, so it is blocked.  This problem will likely be resolved
# upstream eventually.
DEPEND="!net-wireless/ipw2100"
RDEPEND="!net-wireless/ipw2100 >=sys-apps/hotplug-20030805-r2"

src_unpack() {

	if ! egrep "^CONFIG_CRYPTO_ARC4=[ym]" ${ROOT}/usr/src/linux/.config >/dev/null
	then
		eerror ""
		eerror "This version of ${PN} requires the ARC4 CryptoAPI module from"
		eerror "the kernel."
		die "ARC4 Crypto support not detected."
	fi
	if ! egrep "^CONFIG_FW_LOADER=[ym]" ${ROOT}/usr/src/linux/.config >/dev/null
	then
		eerror ""
		eerror "This version of ${PN} require firmware loader support from"
		eerror "your kernel. This can be found in Device Drivers --> Generic"
		eerror "Driver Support on 2.6 or in Library Routines on 2.4 kernels."
		die "Firmware loading support not detected."
	fi

	if ! egrep "^CONFIG_CRC32=[ym]" ${ROOT}/usr/src/linux/.config >/dev/null
	then
		eerror ""
		eerror "This version of ${PN} requires support for CRC32 in"
		eerror "your kernel. This can be found in Library Routines in"
		eerror "kernel configs."
		die "CRC32 function support not detected."
	fi

	unpack ${A}
	kernel-mod_getversion

	if [ ${KV_MINOR} -gt 5 ] && [ ${KV_PATCH} -gt 5 ]
	then
		sed -i 's:SUBDIRS=:M=:g' ${S}/Makefile
	fi
}

src_compile() {
	unset ARCH

	# Build WPA support
	emake KSRC=${ROOT}/usr/src/linux all CONFIG_IEEE80211_WPA=y || die
}

src_install() {
	if [ ${KV_MINOR} -gt 4 ]
	then
		KV_OBJ="ko"
	else
		KV_OBJ="o"
	fi

	dodoc ISSUES README.${PN} CHANGES

	insinto /lib/modules/${KV}/net
	doins ieee80211_crypt.${KV_OBJ} ieee80211_crypt_wep.${KV_OBJ} \
		ieee80211_crypt_ccmp.${KV_OBJ} ieee80211_crypt_tkip.${KV_OBJ} \
		ieee80211.${KV_OBJ} ${PN}.${KV_OBJ}

	insinto /usr/lib/hotplug/firmware
	doins ${WORKDIR}/${PN}_boot.fw
	doins ${WORKDIR}/${PN}_bss.fw
	doins ${WORKDIR}/${PN}_ibss.fw
	doins ${WORKDIR}/${PN}_ucode.fw
}

pkg_postinst() {
	einfo "Checking kernel module dependancies"
	test -r "${ROOT}/usr/src/linux/System.map" && \
		depmod -ae -F "${ROOT}/usr/src/linux/System.map" -b "${ROOT}" -r ${KV}
}
