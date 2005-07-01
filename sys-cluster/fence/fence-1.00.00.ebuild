# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/fence/fence-1.00.00.ebuild,v 1.2 2005/07/01 09:55:05 dholm Exp $


CLUSTER_VERSION="1.00.00"
DESCRIPTION="I/O fencing system"
HOMEPAGE="http://sources.redhat.com/cluster/"

SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/cluster-${CLUSTER_VERSION}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=">=sys-cluster/ccs-1.00.00
	>=sys-cluster/cman-kernel-1.00.00"


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
