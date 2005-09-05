# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gfs-headers/gfs-headers-1.00.00.ebuild,v 1.2 2005/09/05 04:13:55 xmerlin Exp $

CLUSTER_VERSION="1.00.00"
DESCRIPTION="GFS headers"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/cluster-${CLUSTER_VERSION}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"

IUSE=""

DEPEND=">=sys-cluster/dlm-headers-1.00.00
	>=sys-cluster/cman-headers-1.00.00"

RDEPEND=""

S="${WORKDIR}/cluster-${CLUSTER_VERSION}/${PN/headers/kernel}"

src_compile() {
	einfo "No compilation necessary"
}

src_install() {
	dodir /usr/include/linux || die
	insinto /usr/include/linux
	insopts -m0644
	doins src/harness/lm_interface.h || die
	doins src/gfs/gfs_ondisk.h || die
	doins src/gfs/gfs_ioctl.h || die
}
