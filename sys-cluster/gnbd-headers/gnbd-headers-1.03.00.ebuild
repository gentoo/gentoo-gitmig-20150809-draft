# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/gnbd-headers/gnbd-headers-1.03.00.ebuild,v 1.2 2006/10/15 14:04:36 xmerlin Exp $

MY_P="cluster-${PV}"

DESCRIPTION="GFS Network Block Devices headers"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="!<sys-cluster/gnbd-kernel-1.03.00"
RDEPEND=""

S="${WORKDIR}/${MY_P}/${PN/headers/kernel}"

src_compile() {
	einfo "No compilation necessary"
}

src_install() {
	insinto /usr/include/linux
	doins src/gnbd.h || die
}
