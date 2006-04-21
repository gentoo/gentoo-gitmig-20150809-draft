# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/bcm43xx/bcm43xx-0.0.1-r20060125.ebuild,v 1.5 2006/04/21 13:10:30 josejx Exp $

inherit linux-mod eutils

DESCRIPTION="Driver for Broadcom 43xx based wireless network devices"
HOMEPAGE="http://bcm43xx.berlios.de"
SRC_URI="mirror://gentoo/${PN}-${PR#r}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="debug"
DEPEND=">=net-wireless/ieee80211softmac-0.1-r2006125"
RDEPEND="${DEPEND}
	    net-wireless/bcm43xx-fwcutter
		>=net-wireless/wireless-tools-28_pre4
		>=sys-apps/hotplug-20040923-r1"

BUILD_TARGETS="modules"
MODULE_NAMES="bcm43xx(net/wireless:)"

CONFIG_CHECK="NET_RADIO FW_LOADER"
use debug && CONFIG_CHECK="${CONFIG_CHECK} DEBUG_FS"
ERROR_NET_RADIO="${P} requires support for \"Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)\"."
ERROR_FW_LOADER="${P} requires \"Hotplug firmware loading support (CONFIG_FW_LOADER)\"."
ERROR_DEBUG_FS="${P} requires Debug Filesystem support (CONFIG_DEBUG_FS) for
buidling with USE=\"debug\"."

S="${WORKDIR}/${PN}-${PR#r}"

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is lt 2 6 15; then
		die "${P} does not support building against kernels older than 2.6.15."
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/add_stats.patch
	epatch ${FILESDIR}/remove_ieee_check.patch
}

src_compile() {
	BUILD_PARAMS="DEBUG=$(use debug && echo y || echo n) KSRC=${KV_DIR} KSRC_OUTPUT=${KV_OUT_DIR} SOFTMAC_DIR=/usr/include/softmac" linux-mod_src_compile
}

src_install() {
	# Install the module
	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst

	if [ -f /lib/modules/${KV_FULL}/net/${PN}.ko ]; then
		einfo
		einfo "Modules from an earlier installation detected. You will need to manually"
		einfo "remove those modules by running the following commands:"
		einfo "  # rm -f /lib/modules/${KV_FULL}/net/${PN}.ko"
		einfo "  # depmod -a"
		einfo
	fi

	einfo "Please read this forum thread for help and troubleshooting:"
	einfo "http://forums.gentoo.org/viewtopic-t-409194.html"
	einfo
}
