# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ipw2200/ipw2200-1.0.6.ebuild,v 1.2 2005/08/09 21:39:38 brix Exp $

inherit eutils linux-mod

# The following works with both pre-releases and releases
MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

IEEE80211_VERSION="1.0.2"
FW_VERSION="2.3"

DESCRIPTION="Driver for the Intel PRO/Wireless 2200BG/2915ABG miniPCI and 2225BG PCI adapters"
HOMEPAGE="http://ipw2200.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="debug"
DEPEND=">=net-wireless/ieee80211-${IEEE80211_VERSION}"
RDEPEND="${DEPEND}
		=net-wireless/ipw2200-firmware-${FW_VERSION}
		net-wireless/wireless-tools"

BUILD_TARGETS="all"
MODULE_NAMES="ipw2200(net/wireless:)"
MODULESD_IPW2200_DOCS="README.ipw2200"

CONFIG_CHECK="NET_RADIO FW_LOADER"
ERROR_NET_RADIO="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."
ERROR_FW_LOADER="${P} requires Hotplug firmware loading support (CONFIG_FW_LOADER)."

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is 2 4; then
		die "${P} does not support building against kernel 2.4.x"
	fi

	BUILD_PARAMS="KSRC=${KV_DIR} KSRC_OUTPUT=${KV_OUT_DIR} IEEE80211_INC=/usr/include"
}

src_unpack() {
	local debug="n"

	unpack ${A}

	use debug && debug="y"
	sed -i -e "s:^\(CONFIG_IPW_DEBUG\)=.*:\1=${debug}:" ${S}/Makefile
}

src_compile() {
	einfo
	einfo "You may safely ignore any errors from compilation that contain"
	einfo "warnings about undefined references to the ieee80211 subsystem."
	einfo

	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install

	dodoc CHANGES ISSUES
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
