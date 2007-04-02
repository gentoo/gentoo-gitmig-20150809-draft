# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/nvidia-cg-toolkit/nvidia-cg-toolkit-1.5.0.ebuild,v 1.2 2007/04/02 18:16:25 armin76 Exp $

inherit versionator

MY_P="Cg-$(get_version_component_range 1-2)"
DESCRIPTION="nvidia's c graphics compiler toolkit"
HOMEPAGE="http://developer.nvidia.com/object/cg_toolkit.html"
SRC_URI="x86? ( http://developer.download.nvidia.com/cg/Cg_$(get_version_component_range 1-2)/${PV}/${MY_P}_x86.tar.gz )
	amd64? ( http://developer.download.nvidia.com/cg/Cg_$(get_version_component_range 1-2)/${PV}/${MY_P}_x86_64.tar.gz )"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="~amd64 x86"
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

	insinto /etc/env.d
	doins "${FILESDIR}"/80cgc

	insinto /usr/include/Cg
	doins usr/include/Cg/*

	doman 	usr/share/man/man3/*

	dodoc usr/local/Cg/MANIFEST usr/local/Cg/README \
	      usr/local/Cg/docs/*.pdf

	docinto runtime/cgGL/html
	dohtml	usr/local/Cg/docs/runtime/cgGL/html/*

	docinto	runtime/cgGL/txt
	dodoc	usr/local/Cg/docs/runtime/cgGL/txt/*

	docinto	runtime/html
	dohtml	usr/local/Cg/docs/runtime/html/*

	docinto	runtime/txt
	dodoc 	usr/local/Cg/docs/runtime/txt/*

	docinto examples
	dodoc   usr/local/Cg/examples/README.examples

	docinto include/GL
	dodoc   usr/local/Cg/include/GL/*

	# Copy all the example code.
	insinto usr/share/doc/${PF}/examples/CgFX_example
	doins   usr/local/Cg/examples/CgFX_example/*
	insinto usr/share/doc/${PF}/examples/CgFX_example/Art
	doins   usr/local/Cg/examples/CgFX_example/Art/*
	insinto usr/share/doc/${PF}/examples/common
	doins   usr/local/Cg/examples/common/*
	insinto usr/share/doc/${PF}/examples/interfaces_ogl
	doins   usr/local/Cg/examples/interfaces_ogl/*
	insinto usr/share/doc/${PF}/examples/runtime_ogl
	doins   usr/local/Cg/examples/runtime_ogl/*
	insinto usr/share/doc/${PF}/examples/runtime_ogl_vertex_fragment
	doins   usr/local/Cg/examples/runtime_ogl_vertex_fragment/*
	insinto usr/share/doc/${PF}/examples/simple_ps
	doins   usr/local/Cg/examples/simple_ps/*
	insinto usr/share/doc/${PF}/examples/simple_vs
	doins   usr/local/Cg/examples/simple_vs/*
}
