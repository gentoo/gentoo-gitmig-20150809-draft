# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/vzquota/vzquota-2.7.0.7.ebuild,v 1.3 2005/12/26 07:31:59 hollow Exp $

inherit eutils toolchain-funcs versionator linux-info

VVER="$(get_version_component_range 1-3 ${PV})"
VREL="$(get_version_component_range 4 ${PV})"
MY_PV="${VVER}-${VREL}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="OpenVZ VPS disk quota utility"
HOMEPAGE="http://openvz.org/"
SRC_URI="http://download.openvz.org/utils/${PN}/${MY_PV}/src/${MY_P}.tar.bz2"

LICENSE="QPL-1.0"
SLOT="0"
KEYWORDS="amd64 x86"

S="${WORKDIR}/${MY_P}"

CONFIG_CHECK="VE VE_CALLS VZ_QUOTA"

pkg_setup() {
	linux-info_pkg_setup
	check_kernel_built
}

src_compile() {
	emake VZKERNEL_HEADERS=${KV_DIR}/include || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
