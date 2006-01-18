# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rt2x00/rt2x00-9999.ebuild,v 1.3 2006/01/18 11:36:15 uberlord Exp $

inherit linux-mod cvs

DESCRIPTION="Driver for the RaLink RT2x00 wireless chipsets"
HOMEPAGE="http://rt2x00.serialmonkey.com"
LICENSE="GPL-2"

ECVS_SERVER="cvs.sourceforge.net:/cvsroot/rt2400"
ECVS_MODULE="source/rt2x00"
ECVS_LOCALNAME="${P}"

KEYWORDS="-*"
IUSE="debug"
#DEPEND="sys-apps/sed"
RDEPEND="net-wireless/wireless-tools"

MODULE_NAMES="
	ieee80211/80211(rt2x00/ieee80211:)
	ieee80211/rate_control(rt2x00/ieee80211:)
	rt2400pci(rt2x00:)
	rt2500pci(rt2x00:)
	rt2500usb(rt2x00:)"

CONFIG_CHECK="NET_RADIO"
ERROR_NET_RADIO="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."

pkg_setup() {
	kernel_is lt 2 6 13 && die "${P} requires at least kernel 2.6.13"

	linux-mod_pkg_setup

	BUILD_PARAMS="KERNDIR=${KV_DIR} KERNOUT=${KV_OUT_DIR}"
	if use debug ; then
		BUILD_TARGETS="debug"
	else
		BUILD_TARGETS="nodebug"
	fi
}

src_compile() {
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
	dodoc CHANGELOG COPYING README THANKS
}

pkg_postinst() {
	linux-mod_pkg_postinst

	ewarn
	ewarn "This is a CVS ebuild - please report any bugs to the rt2x00 forums"
	ewarn "http://rt2x00.serialmonkey.com/phpBB2/viewforum.php?f=5"
	ewarn
	ewarn "Any bugs reported to Gentoo will be marked INVALID"
	ewarn
}
