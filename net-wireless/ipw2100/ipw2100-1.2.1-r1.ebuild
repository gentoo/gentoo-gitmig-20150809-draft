# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ipw2100/ipw2100-1.2.1-r1.ebuild,v 1.3 2006/04/22 14:41:58 brix Exp $

inherit eutils linux-mod

# The following works with both pre-releases and releases
MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

IEEE80211_VERSION="1.1.12"
FW_VERSION="1.3"

DESCRIPTION="Driver for the Intel PRO/Wireless 2100 3B miniPCI adapter"
HOMEPAGE="http://ipw2100.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE="debug"
DEPEND=">=net-wireless/ieee80211-${IEEE80211_VERSION}"
RDEPEND="${DEPEND}
		=net-wireless/ipw2100-firmware-${FW_VERSION}
		>=net-wireless/wireless-tools-27_pre23"

BUILD_TARGETS="all"
MODULE_NAMES="ipw2100(net/wireless:)"
MODULESD_IPW2100_DOCS="README.ipw2100"

CONFIG_CHECK="NET_RADIO FW_LOADER !IPW2100"
ERROR_NET_RADIO="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."
ERROR_FW_LOADER="${P} requires Hotplug firmware loading support (CONFIG_FW_LOADER)."
ERROR_IPW2100="${P} requires the in-kernel version of the IPW2100 driver to be disabled (CONFIG_IPW2100)"

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is 2 4; then
		die "${P} does not support building against kernel 2.4.x"
	fi

	if [[ ! -f ${ROOT}/lib/modules/${KV_FULL}/net/ieee80211/ieee80211.${KV_OBJ} ]]; then
		eerror
		eerror "Looks like you forgot to remerge net-wireless/ieee80211 after"
		eerror "upgrading your kernel."
		eerror
		eerror "Hint: use sys-kernel/module-rebuild for keeping track of which"
		eerror "modules needs to be remerged after a kernel upgrade."
		eerror
		die "${ROOT}/lib/modules/${KV_FULL}/net/ieee80211/ieee80211.${KV_OBJ} not found"
	fi

	BUILD_PARAMS="KSRC=${KV_DIR} KSRC_OUTPUT=${KV_OUT_DIR} IEEE80211_INC=/usr/include"
}

src_unpack() {
	local debug="n"

	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-cflags.patch

	use debug && debug="y"
	sed -i -e "s:^\(CONFIG_IPW2100_DEBUG\)=.*:\1=$debug:" ${S}/Makefile
}

src_compile() {
	linux-mod_src_compile

	einfo
	einfo "You may safely ignore any warnings from above compilation about"
	einfo "undefined references to the ieee80211 subsystem."
	einfo
}

src_install() {
	linux-mod_src_install

	dodoc CHANGES
}

pkg_postinst() {
	linux-mod_pkg_postinst

	if [ -f /lib/modules/${KV_FULL}/net/${PN}.ko ]; then
		einfo
		einfo "Modules from an earlier installation detected. You will need to manually"
		einfo "remove those modules by running the following commands:"
		einfo "  # rm -f /lib/modules/${KV_FULL}/net/${PN}.ko"
		einfo "  # rm -f /lib/modules/${KV_FULL}/net/ieee80211*.ko"
		einfo "  # depmod -a"
		einfo
	fi
}
