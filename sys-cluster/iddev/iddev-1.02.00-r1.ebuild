# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/iddev/iddev-1.02.00-r1.ebuild,v 1.4 2007/03/09 10:45:28 xmerlin Exp $

CLUSTER_RELEASE="1.02.00"
MY_P="cluster-${CLUSTER_RELEASE}"

DESCRIPTION="iddev is a library that identifies device contents."
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}/${PN}"

src_compile() {
	./configure || die "configure problem"
	emake || die "compile problem"
}

src_install() {
	emake DESTDIR=${D} install || die "install problem"
}
