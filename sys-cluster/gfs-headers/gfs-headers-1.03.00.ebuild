# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gfs-headers/gfs-headers-1.03.00.ebuild,v 1.3 2007/05/12 13:21:36 xmerlin Exp $

CLUSTER_RELEASE="1.03.00"
MY_P="cluster-${CLUSTER_RELEASE}"


DESCRIPTION="GFS headers"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}/${PN/headers/kernel}"

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
