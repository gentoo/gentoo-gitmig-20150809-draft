# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/drbd-kernel/drbd-kernel-0.7.24.ebuild,v 1.2 2007/10/05 20:37:07 xmerlin Exp $

inherit eutils versionator linux-mod

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

MY_PN="${PN/-kernel/}"
MY_P="${MY_PN}-${PV}"
MY_MAJ_PV="$(get_version_component_range 1-2 ${PV})"

HOMEPAGE="http://www.drbd.org"
DESCRIPTION="mirror/replicate block-devices across a network-connection"
SRC_URI="http://oss.linbit.com/drbd/${MY_MAJ_PV}/${MY_PN}-${PV}.tar.gz"

IUSE=""

DEPEND="virtual/linux-sources"
RDEPEND=""
SLOT="0"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	MODULE_NAMES="drbd(block:${S}/drbd)"
	BUILD_TARGETS="default"
	CONFIG_CHECK="CONNECTOR"
	CONNECTOR_ERROR="You must enable \"CONNECTOR - unified userspace <-> kernelspace linker\" in your kernel configuration, because drbd needs it."
	linux-mod_pkg_setup
	BUILD_PARAMS="-j1 KDIR=${KERNEL_DIR} O=${KBUILD_OUTPUT}"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${MY_PN}-0.7.22-nodevfs.patch || die
	epatch "${FILESDIR}"/${MY_PN}-0.7.22-scripts.adjust_drbd_config_h.sh.patch || die
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo ""
	einfo "Please remember to re-emerge drbd when you upgrade your kernel!"
	einfo ""
}
