# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/e100/e100-2.1.24.ebuild,v 1.3 2003/04/28 12:53:36 agenkin Exp $

DESCRIPTION="Linux Base Driver for the Intel(R) PRO/100 Family of Adapters"
HOMEPAGE="http://support.intel.com/support/network/adapter/index.htm"
LICENSE="GPL-2"
DEPEND="virtual/linux-sources"

SRC_URI="http://aiedownload.intel.com/df-support/2896/eng/${P}.tar.gz"
S="${WORKDIR}/${P}"
SLOT="0"
KEYWORDS="x86"

src_compile() {
	check_KV
	cd "${S}/src"
	make KSRC=/usr/src/linux clean e100.o || die
}

src_install () {
	insinto "/lib/modules/${KV}/kernel/drivers/net"
	doins ${S}/src/e100.o
	doman e100.7
	dodoc LICENSE README SUMS e100.spec ldistrib.txt
}

pkg_postinst() {
	einfo ""
	einfo "Please add e100 to your /etc/modules.autoload and"
	einfo "remove eepro100 from your /etc/modules.autoload"
	einfo "if it is present."
	einfo "If you would like to enable the module now:"
	einfo "       depmod"
	einfo "       modprobe e100"
	einfo ""
}
