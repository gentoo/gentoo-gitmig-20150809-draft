# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/dlm-headers/dlm-headers-1.02.00-r1.ebuild,v 1.5 2007/03/09 10:48:32 xmerlin Exp $

inherit eutils

CLUSTER_RELEASE="1.02.00"
MY_P="cluster-${CLUSTER_RELEASE}"
CVS_RELEASE="20060714"

DESCRIPTION="General-purpose Distributed Lock Manager headers"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz
	mirror://gentoo/${PN/headers/kernel}-${PV}-${CVS_RELEASE}-cvs.patch.gz
	http://dev.gentoo.org/~xmerlin/gfs/${PN/headers/kernel}-${PV}-${CVS_RELEASE}-cvs.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ppc64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}/${PN/headers/kernel}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${PN/headers/kernel}-${PV}-${CVS_RELEASE}-cvs.patch || die
}

src_compile() {
	einfo "No compilation necessary"
}

src_install() {
	insinto /usr/include/cluster
	doins src/dlm.h src/dlm_device.h || die

	insinto /usr/include
	doins ../dlm/lib/libdlm.h || die
}
