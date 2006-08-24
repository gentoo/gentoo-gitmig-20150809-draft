# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/cman-headers/cman-headers-1.02.00-r1.ebuild,v 1.3 2006/08/24 18:40:12 xmerlin Exp $

inherit eutils

CVS_RELEASE="20060714"
MY_P="cluster-${PV}"

DESCRIPTION="CMAN cluster headers"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz
	mirror://gentoo/${PN/headers/kernel}-${PV}-${CVS_RELEASE}-cvs.patch.gz
	http://dev.gentoo.org/~xmerlin/gfs/${PN/headers/kernel}-${PV}-${CVS_RELEASE}-cvs.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 x86"

IUSE=""
DEPEND="!<sys-cluster/cman-kernel-1.02.00-r1"
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
	dodir /usr/include/cluster || die
	insinto /usr/include/cluster
	insopts -m0644
	doins src/cnxman.h src/cnxman-socket.h src/service.h || die
}

