# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rt2x00/rt2x00-9999.ebuild,v 1.7 2006/07/11 12:04:18 uberlord Exp $

inherit linux-mod cvs

DESCRIPTION="Driver for the RaLink RT2x00 wireless chipsets"
HOMEPAGE="http://rt2x00.serialmonkey.com"
LICENSE="GPL-2"

ECVS_SERVER="rt2400.cvs.sourceforge.net:/cvsroot/rt2400"
ECVS_MODULE="source/rt2x00"
ECVS_LOCALNAME="${P}"

KEYWORDS="-* ~amd64 ~x86"
IUSE="debug"
RDEPEND="net-wireless/wireless-tools"

MODULE_NAMES="
	80211(rt2x00:)
	rfkill(rt2x00:)
	rate_control(rt2x00:)
	rt2400pci(rt2x00:)
	rt2500pci(rt2x00:)
	rt2500usb(rt2x00:)
	rt61pci(rt2x00:)
	rt73usb(rt2x00:)"

CONFIG_CHECK="NET_RADIO"
ERROR_NET_RADIO="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."

CONFIG_CHECK="FW_LOADER"
ERROR_NET_RADIO="${P} requires support for Firmware module loading (CONFIG_FW_LOADER)."

pkg_setup() {
	kernel_is lt 2 6 13 && die "${P} requires at least kernel 2.6.13"
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNDIR=${KV_DIR} KERNOUT=${KV_OUT_DIR}"
	BUILD_TARGETS=" " # Target "module" is not supported, so we blank it
}

src_compile() {
	local m= d="n"
	use debug && debug="y"

	# Build everything except ASM files
	# Maybe have USE flags for each driver at some point?
	for m in RT2400PCI RT2500PCI RT2500USB RT61PCI RT73USB \
		D80211 RFKILL; do
		echo "CONFIG_${m}=y" >> config
		echo "CONFIG_${m}_ASM=n" >> config
		echo "CONFIG_${m}_DEBUG=${debug}" >> config
		echo "CONFIG_${m}_BUTTON=y" >> config
	done

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
