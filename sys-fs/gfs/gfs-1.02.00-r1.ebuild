# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/gfs/gfs-1.02.00-r1.ebuild,v 1.3 2006/08/24 18:58:41 xmerlin Exp $

inherit linux-mod eutils

CVS_RELEASE="20060713"
MY_P="cluster-${PV}"

DESCRIPTION="Shared-disk cluster file system"
HOMEPAGE="http://sources.redhat.com/cluster/"
SRC_URI="ftp://sources.redhat.com/pub/cluster/releases/${MY_P}.tar.gz
	mirror://gentoo/${PN}-${PV}-${CVS_RELEASE}-cvs.patch.gz
	http://dev.gentoo.org/~xmerlin/gfs/${PN}-${PV}-${CVS_RELEASE}-cvs.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND=">=sys-cluster/gfs-headers-1.02.00-r1
	>=sys-cluster/iddev-1.02.00
	sys-fs/e2fsprogs
	"

RDEPEND="sys-fs/e2fsprogs
	>=sys-cluster/ccs-1.02.00-r1
	>=sys-cluster/cman-1.02.00-r1
	>=sys-cluster/magma-1.02.00-r1
	>=sys-cluster/magma-plugins-1.02.00-r1
	>=sys-cluster/fence-1.02.00-r1
	"

S="${WORKDIR}/${MY_P}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${PN}-${PV}-${CVS_RELEASE}-cvs.patch || die
}

src_compile() {
	check_KV
	set_arch_to_kernel

	./configure --kernel_src=${KERNEL_DIR} || die
	emake || die
}


src_install() {
	make DESTDIR=${D} install || die

	keepdir /etc/cluster || die

	newinitd ${FILESDIR}/${PN}.rc ${PN} || die
}

