# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/gfs/gfs-6.1_pre21.ebuild,v 1.1 2005/03/19 17:32:19 xmerlin Exp $

inherit linux-mod

MY_PV="${PV/_/-}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Shared-disk cluster file system"
HOMEPAGE="http://sources.redhat.com/cluster/"
#SRC_URI="http://people.redhat.com/cfeist/cluster/tgz/${MY_P}.tar.gz"

SRC_URI="mirror://gentoo/${MY_P}.tar.gz
	http://dev.gentoo.org/~xmerlin/gfs/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=sys-cluster/gfs-kernel-2.6.9-r1
	>=sys-cluster/iddev-1.9
	sys-fs/e2fsprogs"

RDEPEND="sys-fs/e2fsprogs"

S="${WORKDIR}/${MY_P}"

src_compile() {
	check_KV
	set_arch_to_kernel

	./configure --kernel_src=${KERNEL_DIR} || die
	emake || die
}


src_install() {
	make DESTDIR=${D} install || die

	exeinto /etc/init.d
	doexe ${FILESDIR}/gfs
	doexe ${FILESDIR}/gfs-mount
}

pkg_postinst() {
	einfo "This package is a container package for all the GFS related utils/libs."
	einfo "For more info see the following URLs:"
	einfo "http://sources.redhat.com/cluster/doc/usage.txt"
	einfo ""
	einfo "Run the following commands on cluster nodes to get everything going:"
	einfo "hint: you need to actually set things up before you do this, see the first URL above"
	einfo "# ccsd"
	einfo "# cman_tool join"
	einfo "# fence_tool join"
	einfo "# mount -t gfs /dev/sdd1 /mnt/gfs ...."
}
