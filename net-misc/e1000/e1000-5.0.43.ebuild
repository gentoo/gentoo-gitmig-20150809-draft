# Copyright 2002 Arcady Genkin <agenkin@thpoon.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/e1000/e1000-5.0.43.ebuild,v 1.2 2003/04/28 12:54:21 agenkin Exp $

DESCRIPTION="Kernel driver for Intel Pro/1000 ethernet adapters."
HOMEPAGE="http://support.intel.com/support/network/adapter/1000/index.htm"
LICENSE="GPL-2"
DEPEND="virtual/linux-sources"

SRC_URI="ftp://aiedownload.intel.com/df-support/5599/eng/${P}.tar.gz"

SLOT="0"
KEYWORDS="x86"
S="${WORKDIR}/${P}"


src_unpack() {
	unpack ${A}
	cd "${S}/src"
	# rem out the DEPVER line, since it would cause a sandbox violation and
	# since it is only needed by RPM ;-)
	sed -e "/^DEPVER :=/ d" < Makefile > Makefile.hacked || die
	mv Makefile.hacked Makefile || die
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
