# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/nvidia-cg-toolkit/nvidia-cg-toolkit-1.2.0402.1900.ebuild,v 1.5 2005/04/07 15:45:04 blubb Exp $

DESCRIPTION="nvidia's c graphics compiler toolkit"
HOMEPAGE="http://developer.nvidia.com/view.asp?IO=cg_toolkit"
SRC_URI="ftp://download.nvidia.com/developer/cg/Cg_1.2/Linux/Cg-1.2.0402-1900.tar.gz"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="virtual/glut"

S=${WORKDIR}

src_install() {
	dobin usr/bin/cgc

	dolib usr/lib/*

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
