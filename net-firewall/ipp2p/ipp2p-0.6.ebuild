# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipp2p/ipp2p-0.6.ebuild,v 1.1 2004/10/26 08:31:50 eradicator Exp $

IUSE=""

inherit kernel-mod eutils

MY_PV=${PV/./}
MY_P="${PN}.${MY_PV}"
S="${WORKDIR}/${PN}"

DESCRIPTION="Netfilter module for dealing with P2P Applications."
HOMEPAGE="http://rnvs.informatik.uni-leipzig.de/ipp2p/index_en.html"
SRC_URI="http://rnvs.informatik.uni-leipzig.de/ipp2p/downloads/${MY_P}.tar.gz"

SLOT="${KV}"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

RDEPEND="virtual/modutils"

DEPEND="${RDEPEND}
	>=net-firewall/iptables-1.2.11
	virtual/linux-sources"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-Makefile.patch
}

src_compile() {
	unset ARCH
	emake KERNEL_SRC=${KERNEL_DIR} || die "Parallel Make Failed"
}


src_install() {
	exeinto /$(get_libdir)/iptables
	doexe libipt_ipp2p.so

	kernel-mod_getversion
	insinto /lib/modules/${KV_MK_VERSION_FULL}/kernel/net/ipv4/netfilter
	doins ipt_ipp2p.ko

	dodoc README
}
