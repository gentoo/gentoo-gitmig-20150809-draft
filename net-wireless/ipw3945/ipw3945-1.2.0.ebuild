# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ipw3945/ipw3945-1.2.0.ebuild,v 1.8 2007/07/10 09:49:50 genstef Exp $

inherit linux-mod eutils

S=${WORKDIR}/${P/_pre/-pre}

UCODE_VERSION="1.13"
DAEMON_VERSION="1.7.22"

DESCRIPTION="Driver for the Intel PRO/Wireless 3945ABG miniPCI express adapter"
HOMEPAGE="http://ipw3945.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/_pre/-pre}.tgz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE="debug"
RDEPEND=">=net-wireless/ipw3945-ucode-${UCODE_VERSION}
	>=net-wireless/ipw3945d-${DAEMON_VERSION}"

BUILD_TARGETS="all"
MODULE_NAMES="ipw3945(net/wireless:)"
MODULESD_IPW3945_DOCS="README.ipw3945"
KV_OBJ="ko"

CONFIG_CHECK="WIRELESS_EXT FW_LOADER IEEE80211 IEEE80211_CRYPT_CCMP IEEE80211_CRYPT_TKIP"
ERROR_WIRELESS_EXT="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions"
ERROR_FW_LOADER="${P} requires Hotplug firmware loading support (CONFIG_FW_LOADER)."
ERROR_IEEE80211="${P} requires support for Generic IEEE 802.11 Networking Stack (CONFIG_IEEE80211)."

pkg_setup() {
	if kernel_is 2 4; then
		die "${P} does not support building against kernel 2.4.x"
	fi

	if kernel_is lt 2 6 18; then
		die "${P} needs a kernel >=2.6.18! Please set your KERNEL_DIR or /usr/src/linux suitably"
	fi

	linux-mod_pkg_setup

	BUILD_PARAMS="KSRC=${KV_DIR} KSRC_OUTPUT=${KV_OUT_DIR}"

	# users don't read changelogs and wonder why the kernel check fails
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
	epatch "${FILESDIR}"/${P}-Makefile.patch

	if use debug ; then
		sed -i -e "s:^\(CONFIG_IPW3945_DEBUG\)=.*:\1=y:" "${S}"/Makefile || \
			die "Failed to enable debugging support!"
	fi
}

src_install() {
	linux-mod_src_install
	dodoc CHANGES ISSUES
}
