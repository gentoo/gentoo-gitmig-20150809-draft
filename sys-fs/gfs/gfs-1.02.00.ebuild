# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/gfs/gfs-1.02.00.ebuild,v 1.1 2006/04/30 13:22:55 xmerlin Exp $

inherit linux-mod

MY_P="cluster-${PV}"

DESCRIPTION="Shared-disk cluster file system"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=sys-cluster/gfs-headers-1.01.00
	>=sys-cluster/iddev-1.01.00
	sys-fs/e2fsprogs
	"

RDEPEND="sys-fs/e2fsprogs
	>=sys-cluster/ccs-1.01.00
	>=sys-cluster/cman-1.01.00
	>=sys-cluster/magma-1.01.00
	>=sys-cluster/magma-plugins-1.01.00
	>=sys-cluster/fence-1.01.00
	"

S="${WORKDIR}/${MY_P}/${PN}"

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

