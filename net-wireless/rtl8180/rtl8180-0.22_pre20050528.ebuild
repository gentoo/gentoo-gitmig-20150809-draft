# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rtl8180/rtl8180-0.22_pre20050528.ebuild,v 1.2 2006/04/22 21:28:29 steev Exp $

inherit linux-mod eutils

DESCRIPTION="Driver for the rtl8180 wireless chipset"
HOMEPAGE="http://rtl8180-sa2400.sourceforge.net"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"

KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="net-wireless/wireless-tools"

MODULE_NAMES="ieee80211_crypt-r8180(net:) ieee80211_crypt_wep-r8180(net:)
	ieee80211-r8180(net:) r8180(net:)"
CONFIG_CHECK="NET_RADIO CRYPTO CRYPTO_ARC4 CRC32"
BUILD_TARGETS="all"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KSRC=${KV_DIR}"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:MODULE_PARM(\([^,]*\),"i");:module_param(\1, int, 0);:' r8180_core.c
}

src_install() {
	linux-mod_src_install

	dodoc AUTHORS CHANGES INSTALL README README.adhoc
}
