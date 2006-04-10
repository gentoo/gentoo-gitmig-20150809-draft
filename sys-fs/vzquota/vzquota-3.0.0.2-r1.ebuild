# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/vzquota/vzquota-3.0.0.2-r1.ebuild,v 1.3 2006/04/10 12:04:33 phreak Exp $

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
IUSE=""

S="${WORKDIR}/${MY_P}"

CONFIG_CHECK="VE VE_CALLS VZ_QUOTA"

pkg_setup() {
	linux-info_pkg_setup
	check_kernel_built
}

src_unpack() {
	unpack ${A}
	ebegin "Applying vzquota-3.0.0.2-version-number-fix.patch ..."
	sed -i "s,2.5.0,3.0.0-2," "${S}"/include/common.h
	eend $?
}

src_compile() {
	emake VZKERNEL_HEADERS=${KV_DIR}/include || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
