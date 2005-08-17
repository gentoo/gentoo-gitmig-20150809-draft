# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ccs/ccs-1.00.00.ebuild,v 1.3 2005/08/17 10:33:41 xmerlin Exp $

CLUSTER_VERSION="1.00.00"
DESCRIPTION="cluster configuration system to manage the cluster config file"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/cluster-${CLUSTER_VERSION}.tar.gz"
IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"

DEPEND=">=sys-cluster/magma-1.00.00
	dev-libs/libxml2
	sys-libs/zlib"

RDEPEND=">=sys-cluster/magma-1.00.00
	dev-libs/libxml2
	sys-libs/zlib
	>=sys-cluster/magma-plugins-1.00.00"


S="${WORKDIR}/cluster-${CLUSTER_VERSION}/${PN}"

src_compile() {
	./configure || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
