# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/prism54/prism54-20050125.ebuild,v 1.1 2005/01/25 17:14:59 genstef Exp $

inherit linux-mod

MY_P=${P/prism54-/prism54-svn=}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Driver for Intersil Prism GT / Prism Duette wireless chipsets"
HOMEPAGE="http://prism54.org/"
SRC_URI="http://prism54.org/pub/linux/snapshot/tars/${PV:0:4}-${PV:4:2}/${MY_P}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="pcmcia"
RDEPEND="net-wireless/prism54-firmware
		net-wireless/wireless-tools
		pcmcia? ( sys-apps/pcmcia-cs )"

MODULE_NAMES="prism54(net:${S}/ksrc)"
BUILD_PARAMS="KVER=${KV_FULL} KDIR=${KV_DIR}"
BUILD_TARGETS="modules"

CONFIG_CHECK="!PRISM54 NET_RADIO FW_LOADER"
PRISM54_ERROR="You need prism54-firmware for the in-kernel driver or deselect
the in-kernel driver to use the (probably older) driver from this ebuild."
NET_RADIO_ERROR='You should enable "Wireless LAN drivers (non-hamradio) &
Wireless Extensions"[CONFIG_NET_RADIO] in your kernel config'
FW_LOADER_ERROR="Make sure you have CONFIG_FW_LOADER enabled in your kernel."

useq pcmcia && CONFIG_CHECK="${CONFIG_CHECK} PCMCIA CARDBUS"
PCMCIA_ERROR=CARDBUS_ERROR="General setup  --->
	PCMCIA/CardBus support  --->
		PCMCIA/CardBus support (m or y)
		[*]   CardBus support (Important!)"

pkg_setup() {
	linux-mod_pkg_setup
	if kernel_is ge 2 6 10; then
		eerror "The driver in your kernel is newer than this snapshot, please use it"
		eerror "together with prism54-firmware instead of this ebuild."
		die "kernel drivers are newer"
	fi
}

src_install() {
	linux-mod_src_install
	dodoc README ksrc/ChangeLog
}
