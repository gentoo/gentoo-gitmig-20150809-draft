# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/e100/e100-3.2.3.ebuild,v 1.1 2004/10/23 15:53:04 mholzer Exp $

DESCRIPTION="Linux base driver for the Intel(R) PRO/100 family of adapters"
HOMEPAGE="http://support.intel.com/support/network/adapter/index.htm"
LICENSE="GPL-2"
DEPEND="virtual/linux-sources"

SRC_URI="mirror://sourceforge/e1000/${P}.tar.gz"
SLOT="${KV}"
KEYWORDS="~x86 ~ppc"
IUSE=""

src_compile() {
	check_KV
	cd "${S}/src"
	emake KSRC=/usr/src/linux clean e100.o || die
}

src_install () {
	insinto "/lib/modules/${KV}/kernel/drivers/net"
	doins ${S}/src/e100.o
	doman e100.7
	dodoc LICENSE README SUMS e100.spec ldistrib.txt
}

pkg_postinst() {
	einfo ""
	einfo "If you are already running the eepro100 driver, you will need "
	einfo "to remove it before loading the e100 driver as they cannot "
	einfo "be used simulaneously."
	einfo ""
	einfo "To load the module at boot up, add e100 to /etc/modules.autoload "
	einfo "and remove eepro100"
	einfo ""
	einfo "To load the module now without rebooting, use the "
	einfo "following command:"
	einfo "modprobe e100"
	einfo ""
	einfo "For more detailed information about this driver, "
	einfo "see the man page by typing:"
	einfo "man 7 e100"
	einfo ""
}
