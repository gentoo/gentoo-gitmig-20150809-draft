# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ralink-rt61/ralink-rt61-1.1.0.0.ebuild,v 1.1 2006/11/30 21:50:53 genstef Exp $

inherit eutils linux-mod

DESCRIPTION="Driver for the RaLink RT61 wireless chipset"
HOMEPAGE="http://www.ralinktech.com/"
LICENSE="GPL-2"

MY_P=${P/${PN}-/RT61_Linux_STA_Drv}

SRC_URI="http://www.ralinktech.com/drivers/Linux/${MY_P}.tar.gz"

KEYWORDS="-* ~amd64 ~x86"
IUSE=""
SLOT="0"

RDEPEND="net-wireless/wireless-tools"

S="${WORKDIR}/${MY_P}"

MODULE_NAMES="rt61(net:${S}/Module)"
BUILD_TARGETS=" "
MODULESD_RT61_ALIASES=('ra? rt61')

CONFIG_CHECK="NET_RADIO"
ERROR_NET_RADIO="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."

src_compile() {
	epatch ${FILESDIR}/rt61-wireless-ext-v21.diff
	if kernel_is 2 6; then
		cp Module/Makefile.6 Module/Makefile
	elif kernel_is 2 4; then
		cp Module/Makefile.4 Module/Makefile
	else
		die "Your kernel version is not supported!"
	fi

	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install

	dodoc Module/{ReleaseNote,STA_iwpriv_ATE_usage.txt,readme,iwpriv_usage.txt}

	insinto /etc/Wireless/RT61STA
	insopts -m 0600
	doins Module/rt61sta.dat
	insopts -m 0644
	doins Module/{rt2561,rt2561s,rt2661}.bin
}
