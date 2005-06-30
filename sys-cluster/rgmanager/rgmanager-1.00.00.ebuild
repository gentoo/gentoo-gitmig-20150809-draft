# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/rgmanager/rgmanager-1.00.00.ebuild,v 1.1 2005/06/30 23:24:49 xmerlin Exp $

inherit linux-mod

CLUSTER_VERSION="1.00.00"
DESCRIPTION="Clustered resource group manager layered on top of Magma"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/cluster-${CLUSTER_VERSION}.tar.gz"
IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"

DEPEND=">=sys-cluster/magma-1.00.00
	>=sys-cluster/magma-plugins-1.00.00
	dev-libs/libxml2
	"

S="${WORKDIR}/cluster-${CLUSTER_VERSION}/${PN}"


src_compile() {
	check_KV
	./configure --kernel_src=${KERNEL_DIR} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
