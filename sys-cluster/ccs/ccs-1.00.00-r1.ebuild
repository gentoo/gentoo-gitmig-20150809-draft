# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ccs/ccs-1.00.00-r1.ebuild,v 1.3 2005/09/05 21:57:58 xmerlin Exp $

CLUSTER_VERSION="1.00.00"
DESCRIPTION="cluster configuration system to manage the cluster config file"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/cluster-${CLUSTER_VERSION}.tar.gz"
IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=sys-cluster/magma-1.00.00
	dev-libs/libxml2
	sys-libs/zlib"


S="${WORKDIR}/cluster-${CLUSTER_VERSION}/${PN}"

src_compile() {
	./configure || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	newinitd ${FILESDIR}/${PN}d.rc ${PN}d || die
	newconfd ${FILESDIR}/${PN}d.conf ${PN}d || die
}
