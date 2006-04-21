# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/vzquota/vzquota-3.0.0.6.ebuild,v 1.2 2006/04/21 07:40:40 phreak Exp $

inherit eutils toolchain-funcs versionator

VVER="$(get_version_component_range 1-3 ${PV})"
VREL="$(get_version_component_range 4 ${PV})"
MY_PV="${VVER}-${VREL}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="OpenVZ VPS disk quota utility"
HOMEPAGE="http://openvz.org/"
SRC_URI="http://download.openvz.org/utils/${PN}/${MY_PV}/src/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
