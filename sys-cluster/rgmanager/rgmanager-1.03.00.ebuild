# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/rgmanager/rgmanager-1.03.00.ebuild,v 1.1 2006/10/15 13:35:17 xmerlin Exp $

inherit eutils

CVS_RELEASE="20060713"
CLUSTER_VERSION="1.03.00"

DESCRIPTION="Clustered resource group manager layered on top of Magma"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/cluster-${CLUSTER_VERSION}.tar.gz"

IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=">=sys-cluster/magma-1.02.00-r1
	>=sys-cluster/magma-plugins-1.02.00-r1
	dev-libs/libxml2
	"

S="${WORKDIR}/cluster-${CLUSTER_VERSION}/${PN}"

src_compile() {
	./configure || die "configure problem"
	emake || die "compile problem"
}

src_install() {
	emake DESTDIR=${D} install || die "install problem"

	newinitd ${FILESDIR}/${PN}.rc ${PN} || die
	newconfd ${FILESDIR}/${PN}.conf ${PN} || die
}
