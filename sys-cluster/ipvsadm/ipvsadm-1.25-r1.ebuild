# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ipvsadm/ipvsadm-1.25-r1.ebuild,v 1.1 2010/09/09 09:40:54 xarthisius Exp $

EAPI=2
inherit linux-info toolchain-funcs eutils

DESCRIPTION="utility to administer the IP virtual server services offered by the Linux kernel"
HOMEPAGE="http://linuxvirtualserver.org/"
SRC_URI="http://www.linuxvirtualserver.org/software/kernel-2.6/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

RDEPEND=">=sys-libs/ncurses-5.2
		dev-libs/libnl"
DEPEND="${RDEPEND}"

pkg_setup() {
	if kernel_is 2 4; then
		eerror "${P} supports only 2.6 kernels, please try ${PN}-1.21 for 2.4 kernels"
		die "wrong kernel version"
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${PF}-build-fixup.diff \
		"${FILESDIR}"/${P}-netlink-conns.diff
}

src_compile() {
	emake -e \
		INCLUDE="-I.. -I." \
		CC="$(tc-getCC)" \
		HAVE_NL=1 \
		 || die "error compiling source"
}

src_install() {
	into /
	dosbin ipvsadm ipvsadm-save ipvsadm-restore || die

	into /usr
	doman ipvsadm.8 ipvsadm-save.8 ipvsadm-restore.8 || die

	newinitd "${FILESDIR}"/ipvsadm-init ipvsadm
	keepdir /var/lib/ipvsadm

	insinto /usr/$(get_libdir)
	dolib.a libipvs/libipvs.a || die
	dolib.so libipvs/libipvs.so || die

	insinto /usr/include/ipvs
	newins libipvs/libipvs.h ipvs.h || die
}

pkg_postinst() {
	einfo "You will need a kernel that has ipvs patches to use LVS."
	einfo "This version is specifically for 2.6 kernels."
}
