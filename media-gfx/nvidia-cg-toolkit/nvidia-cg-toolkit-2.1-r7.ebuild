# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/nvidia-cg-toolkit/nvidia-cg-toolkit-2.1-r7.ebuild,v 1.1 2003/05/03 02:13:00 blauwers Exp $

DESCRIPTION="nvidia's c graphics compiler toolkit"
HOMEPAGE="http://developer.nvidia.com/view.asp?IO=cg_toolkit"
SRC_URI="ftp://download.nvidia.com/developer/cg/Cg-1.1.0303-0400.tar.gz"
LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="~x86"
IUSE="glut"
DEPEND="virtual/glut"
S="${WORKDIR}"

src_install() {
	dobin usr/bin/cgc
	
	dolib usr/lib/*

	insinto /etc/env.d
	doins ${FILESDIR}/80cgc

	insinto /usr/include/Cg
	doins usr/include/Cg/*

	dodoc usr/local/Cg/MANIFEST usr/local/Cg/README \
	      usr/local/Cg/docs/Cg_Toolkit.pdf \
		  usr/local/Cg/docs/GettingStarted.pdf \
		  usr/local/Cg/docs/runtimeTransition.pdf \

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

	#docinto include/Cg
	#dodoc   usr/local/Cg/include/GL/glext.h

	doman 	usr/share/man/man3/*
}
