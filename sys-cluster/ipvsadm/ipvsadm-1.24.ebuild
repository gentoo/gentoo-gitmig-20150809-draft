# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ipvsadm/ipvsadm-1.24.ebuild,v 1.12 2006/04/22 05:52:02 vapier Exp $

inherit linux-info

DESCRIPTION="utility to administer the IP virtual server services offered by the Linux kernel"
HOMEPAGE="http://linuxvirtualserver.org/"
SRC_URI="http://www.linuxvirtualserver.org/software/kernel-2.5/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~s390 x86"
IUSE=""

DEPEND="virtual/linux-sources
	>=sys-libs/ncurses-5.2"

pkg_setup() {
	if kernel_is 2 4; then
		die "${P} supports only 2.6 kernels, please try ${PN}-1.21 for 2.4 kernels"
	fi
}


src_compile() {
	check_KV
	make || die "error compiling source"
}

src_install() {
	into /
	dosbin ipvsadm ipvsadm-save ipvsadm-restore || die

	doman ipvsadm.8 ipvsadm-save.8 ipvsadm-restore.8 || die

	newinitd "${FILESDIR}"/ipvsadm-init ipvsadm
	keepdir /var/lib/ipvsadm

	diropts -m 755 -o root -g root
	dodir /usr/lib
	dodir /usr/include/ipvs

	insopts -m 644 -o root -g root
	insinto /usr/lib
	doins libipvs/libipvs.a || die

	insinto /usr/include/ipvs
	newins libipvs/libipvs.h ipvs.h || die
}

pkg_postinst() {
	einfo "You will need a kernel that has ipvs patches to use LVS."
	einfo "This version is specifically for 2.6 kernels."
}
