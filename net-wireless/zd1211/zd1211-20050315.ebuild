# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/zd1211/zd1211-20050315.ebuild,v 1.2 2005/05/15 19:33:44 josejx Exp $

inherit linux-mod

DESCRIPTION="Driver for the zd1211 wireless chipset"
HOMEPAGE="http://zd1211.sourceforge.net/"
SRC_URI="mirror://sourceforge/zd1211/sf_${PN}_${PV}_src.tar.gz"
S=${WORKDIR}/${PN}
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
	emake -C tools
}

src_install() {
	linux-mod_src_install
	dobin tools/apdbg
	dodoc README CHANGES
}
