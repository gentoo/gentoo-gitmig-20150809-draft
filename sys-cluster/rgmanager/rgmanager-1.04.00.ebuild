# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/rgmanager/rgmanager-1.04.00.ebuild,v 1.1 2007/03/10 12:06:07 xmerlin Exp $

inherit eutils

CLUSTER_RELEASE="1.04.00"
MY_P="cluster-${CLUSTER_RELEASE}"
CVS_RELEASE="20060713"

DESCRIPTION="Clustered resource group manager layered on top of Magma"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz"

IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="=sys-cluster/magma-${CLUSTER_RELEASE}*
	=sys-cluster/magma-plugins-${CLUSTER_RELEASE}*
	dev-libs/libxml2
	"

S="${WORKDIR}/${MY_P}/${PN}"

src_compile() {
	./configure || die "configure problem"
	emake || die "compile problem"
}

src_install() {
	emake DESTDIR=${D} install || die "install problem"

	newinitd ${FILESDIR}/${PN}.rc ${PN} || die
	newconfd ${FILESDIR}/${PN}.conf ${PN} || die
}
