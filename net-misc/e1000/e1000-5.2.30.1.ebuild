# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/e1000/e1000-5.2.30.1.ebuild,v 1.5 2004/07/15 02:45:39 agriffis Exp $

DESCRIPTION="Kernel driver for Intel Pro/1000 ethernet adapters."
HOMEPAGE="http://support.intel.com/support/network/adapter/1000/index.htm"
LICENSE="GPL-2"
DEPEND="virtual/linux-sources"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
SLOT="${KV}"
KEYWORDS="x86"
IUSE=""


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

	# workaround needed for some ethernet controllers to work with low end switches
	if [[ ${USE_INCOMPATIBLE_SWITCH} ]]
		then CFLAGS_EXTRA="CFLAGS_EXTRA=-DE_1000_MASTER_SLAVE=1"
		else CFLAGS_EXTRA=""
	fi

	make ${CFLAGS_EXTRA} KSRC=/usr/src/linux clean e1000.o
}


src_install() {
	insinto "/lib/modules/${KV}/kernel/drivers/net"
	doins "${S}/src/e1000.o"
	doman e1000.7
	dodoc LICENSE README SUMS e1000.spec ldistrib.txt ${FILESDIR}/README.Gentoo
	einfo ""
	einfo "In case you have problems, loading the module, try to run depmod -A"
	einfo ""
	einfo "If you experience problems with low-end switches, read"
	einfo "/usr/share/doc/${PF}/README.Gentoo.gz for a possible workaround"
	einfo ""
}
