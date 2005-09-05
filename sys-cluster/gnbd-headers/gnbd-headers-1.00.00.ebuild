# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gnbd-headers/gnbd-headers-1.00.00.ebuild,v 1.4 2005/09/05 13:25:37 swegener Exp $

CLUSTER_VERSION="1.00.00"
DESCRIPTION="GFS Network Block Devices headers"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/cluster-${CLUSTER_VERSION}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="!<=sys-cluster/gnbd-kernel-1.00.00"
RDEPEND=""

S="${WORKDIR}/cluster-${CLUSTER_VERSION}/${PN/headers/kernel}"

src_compile() {
	einfo "No compilation necessary"
}

src_install() {
	insinto /usr/include/linux
	doins src/gnbd.h || die
}
