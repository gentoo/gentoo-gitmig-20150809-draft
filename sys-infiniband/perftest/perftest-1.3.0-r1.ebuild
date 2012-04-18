# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-infiniband/perftest/perftest-1.3.0-r1.ebuild,v 1.1 2012/04/18 16:45:55 alexxy Exp $

EAPI="4"

OFED_VER="1.5.4.1"
OFED_SUFFIX="0.58.g8f82435"
OFED_SNAPSHOT="1"

inherit openib

DESCRIPTION="OpenIB uverbs micro-benchmarks"

KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="
	sys-infiniband/libibverbs:${SLOT}
	sys-infiniband/librdmacm:${SLOT}"
RDEPEND="${DEPEND}"
block_other_ofed_versions

src_install() {
	dodoc README runme
	dobin ib_*
	dobin rdma_*
}
