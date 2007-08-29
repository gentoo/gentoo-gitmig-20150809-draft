# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/prism54/prism54-20050125.ebuild,v 1.4 2007/08/29 18:52:15 genstef Exp $

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
		net-wireless/wireless-tools"

MODULE_NAMES="prism54(net:${S}/ksrc)"
BUILD_TARGETS="modules"

CONFIG_CHECK="!PRISM54 WIRELESS_EXT FW_LOADER"
PRISM54_ERROR="You need prism54-firmware for the in-kernel driver or deselect
the in-kernel driver to use the (probably older) driver from this ebuild."
WIRELESS_EXT_ERROR='You should enable "Wireless LAN drivers (non-hamradio) &
Wireless Extensions"[CONFIG_WIRELESS_EXT] in your kernel config'
FW_LOADER_ERROR="Make sure you have CONFIG_FW_LOADER enabled in your kernel."

use pcmcia && CONFIG_CHECK="${CONFIG_CHECK} PCMCIA CARDBUS"
PCMCIA_ERROR=CARDBUS_ERROR="General setup  --->
	PCMCIA/CardBus support  --->
		PCMCIA/CardBus support (m or y)
		[*]   CardBus support (Important!)"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KVER=${KV_FULL} KDIR=${KV_DIR}"
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
