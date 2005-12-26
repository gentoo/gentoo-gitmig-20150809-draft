# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/nvidia-cg-toolkit/nvidia-cg-toolkit-1.3.0501.0700.ebuild,v 1.2 2005/12/26 17:57:11 vanquirius Exp $

DESCRIPTION="nvidia's c graphics compiler toolkit"
HOMEPAGE="http://developer.nvidia.com/object/cg_toolkit.html"
SRC_URI="x86? ( ftp://download.nvidia.com/developer/cg/Cg_1.3/Linux/Cg-1.3.0501-0700.i386.tar.gz )
		amd64? ( ftp://download.nvidia.com/developer/cg/Cg_1.3/Linux64/Cg-1.3.0501-0700.x86_64.tar.gz )"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/glut"

S=${WORKDIR}

src_install() {
	dobin usr/bin/cgc

	if use x86; then
		dolib usr/lib/*
	elif use amd64; then
		dolib usr/lib64/*
	fi

	insinto /etc/env.d
	doins ${FILESDIR}/80cgc

	insinto /usr/include/Cg
	doins usr/include/Cg/*
	insinto /usr/include/CgFX
	doins usr/include/CgFX/*

	doman 	usr/share/man/man3/*

	dodoc usr/local/Cg/MANIFEST usr/local/Cg/README \
	      usr/local/Cg/docs/*.pdf

	docinto runtime/cgGL/html
	dodoc	usr/local/Cg/docs/runtime/cgGL/html/*

	docinto	runtime/cgGL/txt
	dodoc	usr/local/Cg/docs/runtime/cgGL/txt/*

	docinto	runtime/html
	dodoc	usr/local/Cg/docs/runtime/html/*

	docinto	runtime/txt
	dodoc 	usr/local/Cg/docs/runtime/txt/*

	docinto examples
	dodoc   usr/local/Cg/examples/README.examples

	docinto examples/common
	dodoc   usr/local/Cg/examples/common/*

	docinto examples/runtime_ogl
	dodoc   usr/local/Cg/examples/runtime_ogl/*

	docinto examples/runtime_ogl_vertex_fragment
	dodoc   usr/local/Cg/examples/runtime_ogl_vertex_fragment/*

	docinto examples/simple_ps
	dodoc   usr/local/Cg/examples/simple_ps/*

	docinto examples/simple_vs
	dodoc   usr/local/Cg/examples/simple_vs/*
}
