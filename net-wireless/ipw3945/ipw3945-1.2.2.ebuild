# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ipw3945/ipw3945-1.2.2.ebuild,v 1.1 2007/09/09 08:35:51 phreak Exp $

inherit linux-mod eutils

S=${WORKDIR}/${P/_pre/-pre}

UCODE_VERSION="1.14.2"
DAEMON_VERSION="1.7.22"

DESCRIPTION="Driver for the Intel PRO/Wireless 3945ABG miniPCI express adapter"
HOMEPAGE="http://ipw3945.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/_pre/-pre}.tgz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug"
RDEPEND=">=net-wireless/ipw3945-ucode-${UCODE_VERSION}
	>=net-wireless/ipw3945d-${DAEMON_VERSION}"

BUILD_TARGETS="all"
MODULE_NAMES="ipw3945(net/wireless:)"
MODULESD_IPW3945_DOCS="README.ipw3945"
KV_OBJ="ko"

CONFIG_CHECK="WIRELESS_EXT FW_LOADER IEEE80211 IEEE80211_CRYPT_CCMP IEEE80211_CRYPT_TKIP"
ERROR_FW_LOADER="${P} requires Hotplug firmware loading support (CONFIG_FW_LOADER)."
ERROR_IEEE80211="${P} requires support for Generic IEEE 802.11 Networking Stack (CONFIG_IEEE80211)."

pkg_setup() {
	if kernel_is 2 4; then
		die "${P} does not support building against kernel 2.4.x"
	fi

	if kernel_is lt 2 6 18; then
		die "${P} needs a kernel >=2.6.18! Please set your KERNEL_DIR or /usr/src/linux suitably"
# I've no idea, why linux-info is passing the above CONFIG_CHECK on any kernel
# <2.6.22, since they don't even *HAVE* that config option. But still linux-info
# isn't bailing.
# 
#	elif kernel_is ge 2 6 22 ; then
#		CONFIG_CHECK="${CONFIG_CHECK} WIRELESS_EXT"
#		ERROR_WIRELESS_EXT="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions"
#	else
#		CONFIG_CHECK="${CONFIG_CHECK} NET_RADIO"
#		ERROR_NET_RADIO="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."
	fi

	linux-mod_pkg_setup

	BUILD_PARAMS="KSRC=${KV_DIR} KSRC_OUTPUT=${KV_OUT_DIR} SHELL=/bin/bash"

	# users don't read the ChangeLog and wonder why the kernel check fails
	# (1) check if the kernel dir (/usr/src/linux) is missing ieee80211

	if [[ -f ${KV_DIR}/include/net/ieee80211.h ]] && \
		[[ -f ${KV_OUT_DIR}/include/config/ieee80211.h ]] && \
		egrep -q "^#(un)?def.*(CONFIG_IEEE80211.*)" ${KV_OUT_DIR}/include/linux/autoconf.h; then
		return 0
	else
		echo
		ewarn "${CATEGORY}/${PF} does NOT use net-wireless/ieee80211 any more."
		ewarn "We are now relying on the in-kernel ieee80211 instead."
		echo
		eerror "Please remove net-wireless/ieee80211 using emerge, and remerge"
		eerror "your current kernel (${KV_FULL}), as it has been altered"
		eerror "by net-wireless/ieee80211."
		die "Incompatible ieee80211 subsystem detected in ${KV_FULL}"
	fi
}

src_unpack() {
	unpack ${P/_pre/-pre}.tgz

	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.2.0-Makefile.patch

	if use debug ; then
		sed -i -e "s:^\(CONFIG_IPW3945_DEBUG\)=.*:\1=y:" "${S}"/Makefile || \
			die "Failed to enable debugging support!"
	fi
}

src_install() {
	linux-mod_src_install
	dodoc CHANGES ISSUES
}

pkg_postinst() {
	elog "If you want your wireless device started up by udev, please make sure"
	elog "you add something like this to your /etc/conf.d/net:"
	elog "preup() {"
	elog "	if [[ ${IFACE} = "wlan0" ]]; then"
	elog "		sleep 3"
	elog "	fi"
	elog "	return 0"
	elog "}"
	elog
	elog "Otherwise, you're going to hit bug #177869 since the driver needs some"
	elog "time to initialize and thus, baselayout is going to start it even if"
	elog "the device isn't useable yet."
	elog
}
