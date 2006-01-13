# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/zd1211/zd1211-20060109.ebuild,v 1.2 2006/01/13 22:31:08 anarchy Exp $

inherit linux-mod toolchain-funcs eutils

DESCRIPTION="Driver for the zd1211 wireless chipset"
HOMEPAGE="http://zd1211.ath.cx/"
SRC_URI="http://zd1211.ath.cx/download/${PN}-driver-r51.tgz"
S=${WORKDIR}/${PN}-driver-r51
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="net-wireless/wireless-tools"
MODULE_NAMES="zd1211(net:)"
BUILD_TARGETS="all"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KSRC=${KV_DIR} KDIR=${KV_DIR}"
}

src_compile() {
	linux-mod_src_compile
	$(tc-getCC) -o apdbg apdbg.c
}

src_install() {
	linux-mod_src_install
	dosbin apdbg

	echo ""
	einfo "Module name has changed from zd1211_mod to zd1211"
	einfo "Please make sure you update it in your modules.autoload/kernel-2.*"
}
