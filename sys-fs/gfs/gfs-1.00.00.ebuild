# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/gfs/gfs-1.00.00.ebuild,v 1.1 2005/06/30 13:47:02 xmerlin Exp $

inherit linux-mod


CLUSTER_VERSION="1.00.00"
DESCRIPTION="Shared-disk cluster file system"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/cluster-${CLUSTER_VERSION}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=sys-cluster/gfs-kernel-1.00.00
	>=sys-cluster/iddev-1.00.00
	sys-fs/e2fsprogs
	"

RDEPEND="sys-fs/e2fsprogs
	>=sys-cluster/ccs-1.00.00
	>=sys-cluster/cman-1.00.00
	>=sys-cluster/magma-1.00.00
	>=sys-cluster/magma-plugins-1.00.00
	=sys-cluster/fence-1.00.00
	"

S="${WORKDIR}/cluster-${CLUSTER_VERSION}/${PN}"

src_compile() {
	check_KV
	set_arch_to_kernel

	./configure --kernel_src=${KERNEL_DIR} || die
	emake || die
}


src_install() {
	make DESTDIR=${D} install || die

	newinitd ${FILESDIR}/${PN}.rc ${PN} || die
}

