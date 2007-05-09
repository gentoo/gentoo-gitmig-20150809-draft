# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/zd1211/zd1211-85.ebuild,v 1.1 2007/05/09 19:33:13 genstef Exp $

inherit linux-mod toolchain-funcs eutils

DESCRIPTION="Driver for the zd1211 wireless chipset"
HOMEPAGE="http://zd1211.ath.cx/"
SRC_URI="http://zd1211.ath.cx/download/${PN}-driver-r${PV}.tgz"
S=${WORKDIR}/${PN}-driver-r${PV}
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND="net-wireless/wireless-tools"

MODULE_NAMES="${PN}(net:${S}/rel_a:${S}) ${PN}b(net:${S}/rel_b:${S})"
BUILD_TARGETS="all"

CONFIG_CHECK="NET_RADIO"
ERROR_NET_RADIO="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."

pkg_setup() {
	linux-mod_pkg_setup

	if kernel_is 2 6; then
		BUILD_PARAMS="KERNEL_SOURCE=${KV_DIR} KDIR=${KV_DIR} KERN_26=y"
	else
		BUILD_PARAMS="KERNEL_SOURCE=${KV_DIR} KDIR=${KV_DIR} KERN_26=n"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	mkdir rel_a rel_b
	echo -e "all:\n\tcd ..; make ZD1211REV_B=0" > rel_a/Makefile
	echo -e "all:\n\tcd ..; make ZD1211REV_B=1" > rel_b/Makefile
}

src_compile() {
	linux-mod_src_compile
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} apdbg.c -o apdbg
}

src_install() {
	linux-mod_src_install
	dosbin apdbg
}

pkg_postinst() {
	linux-mod_pkg_postinst

	ewarn "This package installs two new modules named zd1211 and zd1211b"
	ewarn "This is done because ZyDAS corp. had made two different versions"
	ewarn "of the ZD1211 Chipset."
	ewarn "Please look at ${HOMEPAGE} to see which one is the best"
	ewarn "for your WiFi adapter or, if you prefer, launch both..."
}
