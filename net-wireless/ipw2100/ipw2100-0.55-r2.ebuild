# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ipw2100/ipw2100-0.55-r2.ebuild,v 1.3 2004/10/01 22:24:49 brix Exp $

inherit kernel-mod eutils

FW_VERSION="1.3"

DESCRIPTION="Driver for the Intel Centrino wireless chipset"

HOMEPAGE="http://ipw2100.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz
		mirror://gentoo/${PN}-fw-${FW_VERSION}.tgz
		mirror://gentoo/${P}-2.4.patch.gz"

LICENSE="GPL-2 ipw2100-fw"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND="!net-wireless/ipw2200"
RDEPEND=">=sys-apps/hotplug-20030805-r2
	 >=net-wireless/wireless-tools-27_pre23"

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

	kernel-mod_getversion

	if [ ${KV_MINOR} -eq 4 ]
	then
		epatch ${WORKDIR}/ipw2100-0.55-2.4.patch
	fi

	cd ${S}
	epatch ${FILESDIR}/ipw2100-0.55_manual-disable.patch
	epatch ${FILESDIR}/ipw2100-0.55-modparam-perm.patch

	einfo "Patching Makefile to enable WPA"
	sed -i -e "s:^# CONFIG_IEEE80211_WPA=:CONFIG_IEEE80211_WPA=:" \
		${S}/Makefile

	# let pkg_postinst() handle depmod
	sed -i "s:/sbin/depmod -a::" ${S}/Makefile

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

	emake KSRC=${ROOT}/usr/src/linux KMISC=${D}/lib/modules/${KV}/net install || die

	dodoc ISSUES README.ipw2100 CHANGES LICENSE

	insinto /lib/firmware
	doins ${WORKDIR}/${PN}-${FW_VERSION}.fw
	doins ${WORKDIR}/${PN}-${FW_VERSION}-p.fw
	doins ${WORKDIR}/${PN}-${FW_VERSION}-i.fw
	newins ${WORKDIR}/LICENSE ${PN}-${FW_VERSION}-LICENSE

	# Create symbolic links for old (<=hotplug-20040920) firmware location
	# See bug #65059
	dodir /usr/lib/hotplug/firmware
	dosym /lib/firmware/${PN}-${FW_VERSION}.fw      /usr/lib/hotplug/firmware/${PN}-${FW_VERSION}.fw
	dosym /lib/firmware/${PN}-${FW_VERSION}-p.fw    /usr/lib/hotplug/firmware/${PN}-${FW_VERSION}-p.fw
	dosym /lib/firmware/${PN}-${FW_VERSION}-i.fw    /usr/lib/hotplug/firmware/${PN}-${FW_VERSION}-i.fw
	dosym /lib/firmware/${PN}-${FW_VERSION}-LICENSE /usr/lib/hotplug/firmware/${PN}-${FW_VERSION}-LICENSE
}

pkg_postinst() {
	einfo "Checking kernel module dependencies"
	test -r "${ROOT}/usr/src/linux/System.map" && \
		depmod -ae -F "${ROOT}/usr/src/linux/System.map" -b "${ROOT}" -r ${KV}
}
