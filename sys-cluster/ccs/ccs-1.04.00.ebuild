# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ccs/ccs-1.04.00.ebuild,v 1.1 2007/03/09 10:57:12 xmerlin Exp $

CLUSTER_RELEASE="1.04.00"
MY_P="cluster-${CLUSTER_RELEASE}"

DESCRIPTION="cluster configuration system to manage the cluster config file"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz"
IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"

DEPEND="=sys-cluster/magma-${CLUSTER_RELEASE}*
	dev-libs/libxml2
	sys-libs/zlib"

S="${WORKDIR}/${MY_P}/${PN}"

src_compile() {
	./configure || die "configure problem"
	emake || die "compile problem"
}

src_install() {
	emake DESTDIR=${D} install || die "install problem"

	newinitd ${FILESDIR}/${PN}d.rc ${PN}d || die
	newconfd ${FILESDIR}/${PN}d.conf ${PN}d || die
}
