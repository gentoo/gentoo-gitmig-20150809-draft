# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/cman-headers/cman-headers-1.02.00.ebuild,v 1.1 2006/04/30 10:39:28 xmerlin Exp $

MY_P="cluster-${PV}"

DESCRIPTION="CMAN cluster headers"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"

IUSE=""
DEPEND="!<sys-cluster/cman-kernel-1.02.00"
RDEPEND=""

S="${WORKDIR}/${MY_P}/${PN/headers/kernel}"

src_compile() {
	einfo "No compilation necessary"
}

src_install() {
	dodir /usr/include/cluster || die
	insinto /usr/include/cluster
	insopts -m0644
	doins src/cnxman.h src/cnxman-socket.h src/service.h || die
}

