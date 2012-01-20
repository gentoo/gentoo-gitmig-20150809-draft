# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/knem/knem-0.9.7.ebuild,v 1.1 2012/01/20 11:40:59 alexxy Exp $

EAPI=4

inherit autotools linux-mod multilib

DESCRIPTION="High-Performance Intra-Node MPI Communication"
HOMEPAGE="http://runtime.bordeaux.inria.fr/knem/"
SRC_URI="http://runtime.bordeaux.inria.fr/knem/download/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug modules"

DEPEND="
		sys-apps/hwloc
		virtual/linux-sources"
RDEPEND="
		sys-apps/hwloc
		sys-apps/module-init-tools"

MODULE_NAMES="knem(misc:${S}/driver/linux)"
BUILD_TARGETS="all"
BUILD_PARAMS="KDIR=${KERNEL_DIR}"

pkg_setup() {
	linux-mod_pkg_setup
}

src_prepare() {
	sed 's:driver/linux::g' -i Makefile.am
	eautoreconf
}

src_configure() {
	econf \
		--enable-hwloc \
		--with-linux="${KERNEL_DIR}" \
		--with-linux-release=${KV_FULL} \
		$(use_enable debug)
}

src_compile() {
	default
	if use modules; then
		cd "${S}/driver/linux"
		linux-mod_src_compile || die "failed to build driver"
	fi
}

src_install() {
	default
	if use modules; then
		cd "${S}/driver/linux"
		linux-mod_src_install || die "failed to install driver"
	fi

	# Drop funny unneded stuff
	rm "${ED}/usr/sbin/knem_local_install" || die
	rmdir "${ED}/usr/sbin" || die
	# install udev rules
	dodir /etc/udev/rules.d
	insinto /etc/udev/rules.d
	doins "${FILESDIR}/45-knem.rules" || die
	rm "${ED}/etc/10-knem.rules" || die
}
