# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rt2x00/rt2x00-2.0.0_beta2.ebuild,v 1.1 2005/11/03 20:32:36 uberlord Exp $

inherit linux-mod

IEEE80211_VERSION="1.1.6"

MY_P="${P/_beta/-b}"
DESCRIPTION="Driver for the RaLink RT2x00 wireless chipsets"
HOMEPAGE="http://rt2x00.serialmonkey.com"
SRC_URI="mirror://sourceforge/rt2400/${MY_P}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"
IUSE="debug"
DEPEND="
	>=net-wireless/ieee80211-${IEEE80211_VERSION}
	sys-apps/sed
"
RDEPEND="
	>=net-wireless/ieee80211-${IEEE80211_VERSION}
	net-wireless/wireless-tools
"

S="${WORKDIR}/${MY_P}"
MODULE_NAMES="
	rt2x00core(net/wireless:) rt2400pci(net/wireless:)
	rt2500pci(net/wireless:) rt2500usb(net/wireless:)
"

CONFIG_CHECK="NET_RADIO BROKEN_ON_SMP !PREEMPT !4KSTACKS"
ERROR_NET_RADIO="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."
ERROR_BROKEN_ON_SMP="${P} does not currently support SMP Processors and Kernels"
ERROR_PREEMPT="${P} does not currently support pre-emption"
ERROR_4KSTACKS="${P} does not currently support 4K Stacks"

pkg_setup() {
	kernel_is lt 2 6 13 && die "${P} requires at least kernel 2.6.13"

	linux-mod_pkg_setup

	if [[ ! -f /lib/modules/${KV_FULL}/net/ieee80211/ieee80211.${KV_OBJ} ]]; then
		eerror
		eerror "Looks like you forgot to remerge net-wireless/ieee80211 after"
		eerror "upgrading your kernel."
		eerror
		eerror "Hint: use sys-kernel/module-rebuild for keeping track of which"
		eerror "modules needs to be remerged after a kernel upgrade."
		eerror
		die "/lib/modules/${KV_FULL}/net/ieee80211/ieee80211.${KV_OBJ} not found"
	fi

	BUILD_PARAMS="-C ${KV_DIR} M=${S}"
	BUILD_TARGETS="modules"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"
	use debug || sed -i 's/default: debug/default: nodebug/g' Makefile
}

src_install() {
	linux-mod_src_install
	dodoc CHANGELOG COPYING README THANKS
}

src_compile() {
	linux-mod_src_compile

	einfo
	einfo "You may safely ignore any warnings from above compilation about"
	einfo "undefined references to the ieee80211 subsystem."
	einfo
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo
	einfo "to set up the card you can use:"
	einfo "- iwconfig from wireless-tools"
	einfo "- iwpriw as described in \"/usr/share/doc/${PF}/README.txt.gz"\"
	einfo
}
