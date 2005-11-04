# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rt2x00/rt2x00-9999.ebuild,v 1.1 2005/11/04 22:05:07 uberlord Exp $

inherit linux-mod cvs

IEEE80211_VERSION="1.1.6"

DESCRIPTION="Driver for the RaLink RT2x00 wireless chipsets"
HOMEPAGE="http://rt2x00.serialmonkey.com"
LICENSE="GPL-2"

ECVS_SERVER="cvs.sourceforge.net:/cvsroot/rt2400"
ECVS_MODULE="experimental/rt2x00_beta"
ECVS_LOCALNAME="${P}"

KEYWORDS="-*"
IUSE="debug"
DEPEND="
	>=net-wireless/ieee80211-${IEEE80211_VERSION}
	sys-apps/sed
"
RDEPEND="
	>=net-wireless/ieee80211-${IEEE80211_VERSION}
	net-wireless/wireless-tools
"

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

	BUILD_PARAMS="KERNDIR=${KV_DIR} KERNOUT=${KV_OUT_DIR}"
	if use debug ; then
		BUILD_TARGETS="rt2x00-debug"
	else
		BUILD_TARGETS="rt2x00-nodebug"
	fi
}

src_install() {
	linux-mod_src_install
	dodoc CHANGELOG COPYING README THANKS
}

src_unpack() {
	cvs_src_unpack
	cd "${S}"

	# We need to remove the ieee80211 stack they supply and use the
	# portage one instead
	mv ieee80211/net/ieee80211_compat.h .
	rm ieee80211 -rf
	sed -i 's,^\(CFLAGS\|CPPFLAGS\) := .*,\1 := -include ieee80211_compat.h $(\1) -I/usr/include,g' Makefile
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
	ewarn "This is a CVS ebuild - please report any bugs to the rt2x00 forums"
	ewarn "http://rt2x00.serialmonkey.com/phpBB2/viewforum.php?f=5"
	ewarn
	ewarn "Any bugs reported to Gentoo will be marked INVALID"
	ewarn
}
