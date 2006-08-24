# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gfs-headers/gfs-headers-1.02.00-r1.ebuild,v 1.4 2006/08/24 18:49:04 xmerlin Exp $

inherit eutils linux-info

CVS_RELEASE="20060714"
MY_P="cluster-${PV}"

DESCRIPTION="GFS headers"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz
	mirror://gentoo/${PN/headers/kernel}-${PV}-${CVS_RELEASE}-cvs-part1.patch.gz
	mirror://gentoo/${PN/headers/kernel}-${PV}-${CVS_RELEASE}-cvs-part2.patch.gz
	http://dev.gentoo.org/~xmerlin/gfs/${PN/headers/kernel}-${PV}-${CVS_RELEASE}-cvs-part1.patch.gz
	http://dev.gentoo.org/~xmerlin/gfs/${PN/headers/kernel}-${PV}-${CVS_RELEASE}-cvs-part2.patch.gz
	"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

IUSE=""

DEPEND=">=sys-cluster/dlm-headers-1.02.00-r1
	>=sys-cluster/cman-headers-1.02.00-r1"

RDEPEND=""

S="${WORKDIR}/${MY_P}/${PN/headers/kernel}"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${WORKDIR}/gfs-kernel-1.02.00-20060714-cvs-part1.patch || die
	if kernel_is 2 6; then
		if [ "$KV_PATCH" -gt "16" ] ; then
			epatch ${WORKDIR}/gfs-kernel-1.02.00-20060714-cvs-part2.patch || die
		fi
	fi
}

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
