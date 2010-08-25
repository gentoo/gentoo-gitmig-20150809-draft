# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/drbd-kernel/drbd-kernel-8.3.8.1.ebuild,v 1.1 2010/08/25 16:35:34 xarthisius Exp $

EAPI="2"

inherit eutils versionator linux-mod

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

MY_PN=${PN/-kernel/}
MY_P=${MY_PN}-${PV}
MY_MAJ_PV=$(get_version_component_range 1-2 ${PV})

HOMEPAGE="http://www.drbd.org"
DESCRIPTION="mirror/replicate block-devices across a network-connection"
SRC_URI="http://oss.linbit.com/drbd/${MY_MAJ_PV}/${MY_PN}-${PV}.tar.gz"

IUSE=""
DEPEND="virtual/linux-sources"
RDEPEND=""
SLOT="0"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	if ! kernel_is 2 6; then
		die "Unsupported kernel, drbd-${PV} needs kernel 2.6.x ."
	fi

	MODULE_NAMES="drbd(block:${S}/drbd)"
	BUILD_TARGETS="default"
	CONFIG_CHECK="CONNECTOR"
	CONNECTOR_ERROR="You must enable \"CONNECTOR - unified userspace <-> kernelspace linker\" in your kernel configuration, because drbd needs it."
	linux-mod_pkg_setup
	BUILD_PARAMS="-j1 KDIR=${KV_DIR} O=${KV_OUT_DIR}"
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo ""
	einfo "Please remember to re-emerge drbd-kernel when you upgrade your kernel!"
	einfo ""
}
