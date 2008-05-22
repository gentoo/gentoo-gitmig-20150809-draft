# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/nvidia-cg-toolkit/nvidia-cg-toolkit-2.0.0010.ebuild,v 1.3 2008/05/22 21:56:23 maekke Exp $

inherit versionator

MY_P="Cg-$(get_version_component_range 1-2)"
DESCRIPTION="nvidia's c graphics compiler toolkit"
HOMEPAGE="http://developer.nvidia.com/object/cg_toolkit.html"
SRC_URI="x86? ( http://developer.download.nvidia.com/cg/Cg_$(get_version_component_range 1-2)/${PV}/${MY_P}_Dec2007_x86.tar.gz )
	amd64? ( http://developer.download.nvidia.com/cg/Cg_$(get_version_component_range 1-2)/${PV}/${MY_P}_Dec2007_x86_64.tar.gz )"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="virtual/glut"

S="${WORKDIR}"

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	dobin usr/bin/cgc

	if use x86; then
		dolib usr/lib/*
	elif use amd64; then
		dolib usr/lib64/*
	fi

	doenvd "${FILESDIR}"/80cgc

	insinto /usr/include/Cg
	doins usr/include/Cg/*

	doman 	usr/share/man/man3/*

	dodoc usr/local/Cg/MANIFEST usr/local/Cg/README \
	      usr/local/Cg/docs/*.pdf

	docinto html
	dohtml	usr/local/Cg/docs/html/*

	docinto	txt/cg
	dodoc	usr/local/Cg/docs/txt/cg/*

	docinto	txt/cgGL
	dodoc	usr/local/Cg/docs/txt/cgGL/*

	docinto	txt/profiles
	dodoc 	usr/local/Cg/docs/txt/profiles/*

	docinto txt/stdlib
	dodoc   usr/local/Cg/docs/txt/stdlib/*

	docinto examples
	dodoc   usr/local/Cg/examples/old/README.examples

	docinto include/GL
	dodoc   usr/local/Cg/include/GL/*

	# Copy all the example code.
	cd usr/local/Cg/examples
	for dir in $(find . -type d) ; do
		insinto usr/share/doc/${PF}/examples/"${dir}"
		doins "${dir}"/*
	done
}
