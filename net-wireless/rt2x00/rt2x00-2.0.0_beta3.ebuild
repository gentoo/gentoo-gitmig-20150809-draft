# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rt2x00/rt2x00-2.0.0_beta3.ebuild,v 1.4 2007/08/29 19:05:19 genstef Exp $

inherit linux-mod eutils

IEEE80211_VERSION="1.1.6"

MY_P="${P/_beta/-b}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Driver for the RaLink RT2x00 wireless chipsets"
HOMEPAGE="http://rt2x00.serialmonkey.com"
SRC_URI="mirror://sourceforge/rt2400/${MY_P}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"
IUSE="debug"
DEPEND=">=net-wireless/ieee80211-${IEEE80211_VERSION}"
RDEPEND="${DEPEND}
	net-wireless/wireless-tools"

MODULE_NAMES="
	rt2x00core(net/wireless:) rt2400pci(net/wireless:)
	rt2500pci(net/wireless:) rt2500usb(net/wireless:)
"

CONFIG_CHECK="WIRELESS_EXT"
ERROR_WIRELESS_EXT="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_WIRELESS_EXT)."

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

	BUILD_PARAMS="KERNDIR=${KV_DIR} KERNOUT=${KV_OUT_DIR}"
	if use debug ; then
		BUILD_TARGETS="rt2x00-debug"
	else
		BUILD_TARGETS="rt2x00-nodebug"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Allow compilation on newer kernels
	epatch "${FILESDIR}/${P}-compat.patch"
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

	ewarn
	ewarn "This is a BETA driver. If you have any issues, test the cvs ebuild"
	ewarn "as your issue may have already been fixed."
	ewarn "Please report any bugs to the rt2x00 forums :-"
	ewarn "http://rt2x00.serialmonkey.com/phpBB2/viewforum.php?f=5"
	ewarn
	ewarn "Any bugs reported to Gentoo will be marked INVALID"
	ewarn
}
