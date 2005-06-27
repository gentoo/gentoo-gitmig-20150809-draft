# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/adm8211/adm8211-20050620.ebuild,v 1.2 2005/06/27 17:24:09 herbs Exp $

inherit linux-mod

S=${WORKDIR}/${PN}

DESCRIPTION="IEEE 802.11 wireless LAN driver for adm8211 based cards"
HOMEPAGE="http://aluminum.sourmilk.net/adm8211/"
SRC_URI="http://aluminum.sourmilk.net/adm8211/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
RDEPEND="net-wireless/wireless-tools"

BUILD_TARGETS="all"

MODULE_NAMES="adm8211(net:)"

CONFIG_CHECK="NET_RADIO CRYPTO_ARC4"
ERROR_NET_RADIO="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."
ERROR_CRYPTO_ARC4="${P} requires support for ARC4 cipher algorithm (CONFIG_CRYPTO_ARC4)."

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is lt 2 6 10; then
		eerror "${P} requires linux-2.6.9 or later."
		die "${P} requires linux-2.6.9 or later"
	fi

	BUILD_PARAMS="KDIR=${KV_DIR}"
}

src_unpack() {
	unpack ${A}

	convert_to_m ${S}/Makefile
}

src_install() {
	linux-mod_src_install

	dodoc Changelog NOTES TODO
}
