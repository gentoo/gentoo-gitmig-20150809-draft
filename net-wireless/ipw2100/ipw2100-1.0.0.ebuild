# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ipw2100/ipw2100-1.0.0.ebuild,v 1.1 2004/11/15 19:45:29 brix Exp $

inherit kernel-mod eutils

FW_VERSION="1.3"

DESCRIPTION="Driver for the Intel PRO/Wireless 2100 3B miniPCI adapter"

HOMEPAGE="http://ipw2100.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz
		mirror://gentoo/${PN}-fw-${FW_VERSION}.tgz"

LICENSE="GPL-2 ipw2100-fw"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND="virtual/linux-sources
		!net-wireless/ipw2200
		sys-apps/sed"
RDEPEND=">=sys-apps/hotplug-20030805-r2
		>=net-wireless/wireless-tools-27_pre23"

pkg_setup() {
	local DIE=0

	if kernel-mod_is_2_4_kernel
	then
		die "${P} does not support building against kernel 2.4.x"
	fi

	if ! kernel-mod_configoption_present NET_RADIO
	then
		eerror ""
		eerror "${P} requires support for Wireless LAN drivers (non-hamradio) &"
		eerror "Wireless Extensions (CONFIG_NET_RADIO) in the kernel."
		DIE=1
	fi

	if ! kernel-mod_configoption_present CRYPTO_ARC4
	then
		eerror ""
		eerror "${P} requires support for ARC4 cipher algorithm (CONFIG_CRYPTO_ARC4)"
		eerror "in the kernel."
		DIE=1
	fi

	if ! kernel-mod_configoption_present CRYPTO_MICHAEL_MIC
	then
		eerror ""
		eerror "${P} requires support for Michael MIC keyed digest algorithm"
		eerror "(CONFIG_CRYPTO_MICHAEL_MIC) in the kernel."
		DIE=1
	fi

	if ! kernel-mod_configoption_present CRYPTO_AES_586 && ! kernel-mod_configoption_present CRYPTO_AES
	then
		eerror ""
		eerror "${P} requires support for AES cipher algorithms (i586)"
		eerror "(CONFIG_CRYPTO_AES_586) in the kernel."
		eerror ""
		eerror "This is called CONFIG_CRYPTO_AES in kernels prior to 2.6.8."
		DIE=1
	fi

	if ! kernel-mod_configoption_present FW_LOADER
	then
		eerror ""
		eerror "${P} requires Hotplug firmware loading support (CONFIG_FW_LOADER)"
		eerror "in the kernel."
		DIE=1
	fi

	if ! kernel-mod_configoption_present CRC32
	then
		eerror ""
		eerror "${P} requires support for CRC32 functions (CONFIG_CRC32) in the"
		eerror "kernel."
		DIE=1
	fi

	kernel-mod_check_modules_supported

	if [ $DIE -eq 1 ]
	then
		eerror ""
		die "You kernel is missing the required option(s) listed above."
	fi
}

src_unpack() {
	unpack ${A}

	einfo "Patching Makefile to enable WPA"
	sed -i "s:^# CONFIG_IEEE80211_WPA=:CONFIG_IEEE80211_WPA=:" \
		${S}/Makefile

	# let pkg_postinst() handle depmod
	sed -i "s:/sbin/depmod -a::" ${S}/Makefile

	kernel-mod_getversion

	if [ ${KV_MINOR} -gt 5 ] && [ ${KV_PATCH} -gt 5 ]
	then
		sed -i 's:SUBDIRS=:M=:g' ${S}/Makefile
	fi
}

src_compile() {
	set_arch_to_kernel

	emake KSRC=${ROOT}/usr/src/linux all || die
}

src_install() {
	set_arch_to_kernel

	emake KSRC=${ROOT}/usr/src/linux KMISC=${D}/lib/modules/${KV}/net install || die

	set_arch_to_portage

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
