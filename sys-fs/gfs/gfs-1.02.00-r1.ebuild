# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/gfs/gfs-1.02.00-r1.ebuild,v 1.7 2007/07/13 05:15:33 mr_bones_ Exp $

inherit eutils

CLUSTER_RELEASE="1.02.00"
MY_P="cluster-${CLUSTER_RELEASE}"
CVS_RELEASE="20060713"

DESCRIPTION="Shared-disk cluster file system"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz
	mirror://gentoo/${PN}-${PV}-${CVS_RELEASE}-cvs.patch.gz
	http://dev.gentoo.org/~xmerlin/gfs/${PN}-${PV}-${CVS_RELEASE}-cvs.patch.gz"

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

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${PN}-${PV}-${CVS_RELEASE}-cvs.patch || die
}

src_compile() {
	./configure || die "configure problem"
	emake || die "compile problem"
}

src_install() {
	emake DESTDIR=${D} install || die "install problem"

	keepdir /etc/cluster || die
	newinitd ${FILESDIR}/${PN}.rc ${PN} || die
}
