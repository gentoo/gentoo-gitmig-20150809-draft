# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ipvsadm/ipvsadm-1.26-r1.ebuild,v 1.5 2011/06/24 12:01:25 armin76 Exp $

EAPI=4

inherit eutils linux-info toolchain-funcs

DESCRIPTION="utility to administer the IP virtual server services"
HOMEPAGE="http://linuxvirtualserver.org/"
SRC_URI="http://www.linuxvirtualserver.org/software/kernel-2.6/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 s390 sparc x86"
IUSE="static-libs"

RDEPEND=">=sys-libs/ncurses-5.2
	dev-libs/libnl
	>=dev-libs/popt-1.16"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if kernel_is 2 4; then
		eerror "${P} supports only 2.6 kernels, please try ${PN}-1.21 for 2.4 kernels"
		die "wrong kernel version"
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-buildsystem.patch
	use static-libs && export STATIC=1
}

src_compile() {
	emake -e \
		INCLUDE="-I.. -I." \
		CC="$(tc-getCC)" \
		HAVE_NL=1 \
		STATIC_LIB=${STATIC} \
		POPT_LIB="$(pkg-config --libs popt)" \
		 || die
}

src_install() {
	into /
	dosbin ipvsadm ipvsadm-save ipvsadm-restore || die

	into /usr
	doman ipvsadm.8 ipvsadm-save.8 ipvsadm-restore.8 || die

	newinitd "${FILESDIR}"/ipvsadm-init ipvsadm
	keepdir /var/lib/ipvsadm

	use static-libs && dolib.a libipvs/libipvs.a
	dolib.so libipvs/libipvs.so || die

	insinto /usr/include/ipvs
	newins libipvs/libipvs.h ipvs.h || die
}

pkg_postinst() {
	einfo "You will need a kernel that has ipvs patches to use LVS."
	einfo "This version is specifically for 2.6 kernels."
}
