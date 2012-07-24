# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/nvidia-cg-toolkit/nvidia-cg-toolkit-2.1.0017.ebuild,v 1.3 2012/07/24 13:09:08 jlec Exp $

inherit versionator

MY_PV="$(get_version_component_range 1-2)"
MY_DATE="February2009"
DESCRIPTION="NVIDIA's C graphics compiler toolkit"
HOMEPAGE="http://developer.nvidia.com/object/cg_toolkit.html"
SRC_URI="x86? ( http://developer.download.nvidia.com/cg/Cg_${MY_PV}/${PV}/Cg-${MY_PV}_${MY_DATE}_x86.tgz )
	amd64? ( http://developer.download.nvidia.com/cg/Cg_${MY_PV}/${PV}/Cg-${MY_PV}_${MY_DATE}_x86_64.tgz )"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="strip"

RDEPEND="media-libs/freeglut"

S=${WORKDIR}

DEST=/opt/${PN}

QA_PREBUILT="${DEST}/*"

src_install() {
	into ${DEST}
	dobin usr/bin/cgc || die
	dosym ${DEST}/bin/cgc /opt/bin/cgc || die

	exeinto ${DEST}/lib
	if use x86 ; then
		doexe usr/lib/* || die
	elif use amd64 ; then
		doexe usr/lib64/* || die
	fi

	doenvd "${FILESDIR}"/80cgc-opt

	insinto ${DEST}/include/Cg
	doins usr/include/Cg/*

	insinto ${DEST}/man/man3
	doins usr/share/man/man3/*

	insinto ${DEST}
	doins -r usr/local/Cg/{docs,examples,README}
}

pkg_postinst() {
	einfo "Starting with ${CATEGORY}/${PN}-2.1.0016, ${PN} is installed in"
	einfo "${DEST}.  Packages might have to add something like:"
	einfo "  append-cppflags -I${DEST}/include"
}
