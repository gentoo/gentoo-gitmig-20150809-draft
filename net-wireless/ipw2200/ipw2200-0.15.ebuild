# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ipw2200/ipw2200-0.15.ebuild,v 1.1 2004/11/25 18:27:43 jbms Exp $

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

	if ! egrep "^CONFIG_NET_RADIO=[ym]" ${ROOT}/usr/src/linux/.config >/dev/null
	then
		eerror ""
		eerror "${PN} requires support for Wireless LAN drivers (non-hamradio) &"
		eerror "Wireless Extensions in the kernel."
		eerror ""
		die "Wireless LAN support not detected."
	fi
	if ! egrep "^CONFIG_CRYPTO_ARC4=[ym]" ${ROOT}/usr/src/linux/.config >/dev/null
	then
		eerror ""
		eerror "New versions of ${PN} require the ARC4 CryptoAPI module from"
		eerror "the kernel."
		eerror ""
		die "ARC4 Crypto support not detected."
	fi

	if ! egrep "^CONFIG_FW_LOADER=[ym]" ${ROOT}/usr/src/linux/.config >/dev/null
	then
		eerror ""
		eerror "New versions of ${PN} require firmware loader support from"
		eerror "your kernel. This can be found in Device Drivers --> Generic"
		eerror "Driver Support on 2.6 or in Library Routines on 2.4 kernels."
		eerror ""
		die "Firmware loading support not detected."
	fi

	if ! egrep "^CONFIG_CRC32=[ym]" ${ROOT}/usr/src/linux/.config >/dev/null
	then
		eerror ""
		eerror "New versions of ${PN} require support for CRC32 in"
		eerror "your kernel. This can be found in Library Routines in"
		eerror "kernel configs."
		eerror ""
		die "CRC32 function support not detected."
	fi

	unpack ${A}

	cd "${S}"

	einfo "Patching Makefile"
	sed -i -e 's/CONFIG_IPW_DEBUG=y/CONFIG_IPW_DEBUG=n/' "${S}/Makefile"
	sed -i -e 's/CONFIG_IEEE80211_DEBUG=y/CONFIG_IEEE80211_DEBUG=n/' "${S}/Makefile"
	sed -i -e 's/# CONFIG_IPW_PROMISC=/CONFIG_IPW_PROMISC=/' "${S}/Makefile"
	sed -i -e 's/# CONFIG_IEEE80211_WPA=/CONFIG_IEEE80211_WPA=/' "${S}/Makefile"

	# let pkg_postinst() handle depmod
	sed -i "s:/sbin/depmod -a::" ${S}/Makefile

	kernel-mod_getversion

	if [ ${KV_MINOR} -gt 5 ] && [ ${KV_PATCH} -gt 5 ]
	then
		sed -i 's:SUBDIRS=:M=:g' ${S}/Makefile
	fi
}

src_compile() {
	if [ ${KV_MINOR} -gt 5 ] && [ ${KV_PATCH} -gt 5 ]
	then
		unset ARCH
	fi

	emake KSRC=${ROOT}/usr/src/linux all || die
}

src_install() {
	if [ ${KV_MINOR} -gt 5 ] && [ ${KV_PATCH} -gt 5 ]
	then
		unset ARCH
	fi

	emake KMISC=${D}/lib/modules/${KV}/net install || die

	dodoc ISSUES README.${PN} CHANGES

	insinto /lib/firmware
	doins ${WORKDIR}/${PN}_boot.fw
	doins ${WORKDIR}/${PN}_bss.fw
	doins ${WORKDIR}/${PN}_ibss.fw
	doins ${WORKDIR}/${PN}_ucode.fw

	# Create symbolic links for old hotplug firmware location
	dodir /usr/lib/hotplug/firmware
	dosym /lib/firmware/${PN}_boot.fw /usr/lib/hotplug/firmware/${PN}_boot.fw
	dosym /lib/firmware/${PN}_bss.fw /usr/lib/hotplug/firmware/${PN}_bss.fw
	dosym /lib/firmware/${PN}_ibss.fw /usr/lib/hotplug/firmware/${PN}_ibss.fw
	dosym /lib/firmware/${PN}_ucode.fw /usr/lib/hotplug/firmware/${PN}_ucode.fw
}

pkg_postinst() {
	einfo "Checking kernel module dependancies"
	test -r "${ROOT}/usr/src/linux/System.map" && \
		depmod -ae -F "${ROOT}/usr/src/linux/System.map" -b "${ROOT}" -r ${KV}
}
