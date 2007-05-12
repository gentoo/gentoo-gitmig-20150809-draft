# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/gfs/gfs-1.03.00.ebuild,v 1.5 2007/05/12 13:36:42 xmerlin Exp $

CLUSTER_RELEASE="1.03.00"
MY_P="cluster-${CLUSTER_RELEASE}"

DESCRIPTION="Shared-disk cluster file system"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="=sys-cluster/gfs-headers-${CLUSTER_RELEASE}*
	=sys-cluster/iddev-${CLUSTER_RELEASE}*
	sys-fs/e2fsprogs
	"

RDEPEND="sys-fs/e2fsprogs
	=sys-cluster/ccs-${CLUSTER_RELEASE}*
	=sys-cluster/cman-${CLUSTER_RELEASE}*
	=sys-cluster/magma-${CLUSTER_RELEASE}*
	=sys-cluster/magma-plugins-${CLUSTER_RELEASE}*
	=sys-cluster/fence-${CLUSTER_RELEASE}*
	"

S="${WORKDIR}/${MY_P}/${PN}"

src_compile() {
	./configure || die "configure problem"
	emake || die "compile problem"
}


src_install() {
	emake DESTDIR=${D} install || die "install problem"

	keepdir /etc/cluster || die
	newinitd ${FILESDIR}/${PN}.rc ${PN} || die
}

