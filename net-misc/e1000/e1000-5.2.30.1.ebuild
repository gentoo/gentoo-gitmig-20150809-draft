# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/e1000/e1000-5.2.30.1.ebuild,v 1.1 2004/02/03 12:15:07 mholzer Exp $

DESCRIPTION="Kernel driver for Intel Pro/1000 ethernet adapters."
HOMEPAGE="http://support.intel.com/support/network/adapter/1000/index.htm"
LICENSE="GPL-2"
DEPEND="virtual/linux-sources"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
SLOT="${KV}"
KEYWORDS="~x86"
S="${WORKDIR}/${P}"


src_unpack() {
	unpack ${A}
	cd ${S}/src
	# rem out the DEPVER line, since it would cause a sandbox violation and
	# since it is only needed by RPM ;-)
	sed -i "/^DEPVER :=/ d" Makefile
}


src_compile() {
	check_KV
	cd "${S}/src"
	make KSRC=/usr/src/linux clean e1000.o
}


src_install() {
	insinto "/lib/modules/${KV}/kernel/drivers/net"
	doins "${S}/src/e1000.o"
	doman e1000.7
	dodoc LICENSE README SUMS e1000.spec ldistrib.txt
	einfo ""
	einfo "In case you have problems, loading the module, try to run depmod -A"
	einfo ""
}
