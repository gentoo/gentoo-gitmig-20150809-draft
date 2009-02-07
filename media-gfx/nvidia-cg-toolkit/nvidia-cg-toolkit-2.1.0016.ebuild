# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/nvidia-cg-toolkit/nvidia-cg-toolkit-2.1.0016.ebuild,v 1.2 2009/02/07 14:39:16 maekke Exp $

inherit versionator

MY_PV="$(get_version_component_range 1-2)"
MY_DATE="November2008"
DESCRIPTION="nvidia's c graphics compiler toolkit"
HOMEPAGE="http://developer.nvidia.com/object/cg_toolkit.html"
SRC_URI="x86? (
	http://developer.download.nvidia.com/cg/Cg_2.0/${PV}/Cg-${MY_PV}_${MY_DATE}_x86.tgz )
	amd64? (
	http://developer.download.nvidia.com/cg/Cg_2.0/${PV}/Cg-${MY_PV}_${MY_DATE}_x86_64.tgz )"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="strip"

DEPEND="virtual/glut"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	local DEST=/opt/${PN}

	into ${DEST}
	dobin usr/bin/cgc || die
	dosym ${DEST}/bin/cgc /opt/bin/cgc || die

	if use x86; then
		dolib usr/lib/* || die
	elif use amd64; then
		dolib usr/lib64/* || die
	fi

	doenvd "${FILESDIR}"/80cgc-opt

	insinto ${DEST}/include/Cg
	doins usr/include/Cg/*

	insinto ${DEST}/man/man3
	doins usr/share/man/man3/*

	insinto ${DEST}/Cg
	doins -r usr/local/Cg/*
}

pkg_postinst() {
	einfo "Starting with ${CATEGORY}/${PN}-2.1.0016, ${PN}"
	einfo "is installed in /opt/${PN}."
}
