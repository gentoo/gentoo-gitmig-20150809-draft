# Copyright 1999-2003 Gentoo Technologies, Inc.
# Copyright 2002 Marius Bernklev <mariube@unixcore.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/sbcl/sbcl-0.8.1.ebuild,v 1.1 2003/06/28 13:29:23 karltk Exp $

DESCRIPTION="Steel Bank Common Lisp"
HOMEPAGE="http://sbcl.sourceforge.net/"
BV_X86=0.8.0.24
BC_PPC=0.7.13
SRC_URI="mirror://sourceforge/sbcl/${P}-source.tar.bz2
	 x86? ( mirror://sourceforge/sbcl/${PN}-${BV_X86}-x86-linux-binary.tar.bz2 )
         ppc? ( mirror://sourceforge/sbcl/${PN}-${BV_PPC}-binary-linux-ppc.tar.bz2 )
	 mirror://sourceforge/sbcl/${P}-html.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~ppc -sparc " 
PROVIDE="virtual/commonlisp"
# the SRC_URI trickery needs this
DEPEND=">=sys-apps/portage-2.0.27"
IUSE=""

src_unpack() {
	
	if ( use x86 ) ; then
		unpack ${PN}-${BV_X86}-x86-linux-binary.tar.bz2
		mv ${PN}-${BV_X86} x86-binary
	elif ( use ppc ) ; then
		unpack ${PN}-${BV_PPC}-ppc-linux-binary.tar.bz2
		mv ${PN}-${BV_PPC}-ppc-linux ppc-binary
	fi
    
	unpack ${P}-source.tar.bz2
	unpack ${P}-html.tar.bz2
}

src_compile() {
	local bindir
	use x86 && bindir=x86-binary
	use ppc && bindir=ppc-binary

	export SBCL_HOME="../${bindir}/output/" 
	export GNUMAKE="make"
    
	sh make.sh "../${bindir}/src/runtime/sbcl" || die
}

src_install() {
	local LIB=${DESTTREE}/lib/sbcl
    
	doman doc/sbcl.1
	dobin src/runtime/sbcl
    
	dodoc BUGS CREDITS NEWS README INSTALL COPYING 
	dohtml doc/html/*
    
	dodir ${LIB}
	insinto ${LIB}
	doins output/sbcl.core
    
	dodir /etc/env.d
    
	echo "SBCL_HOME=${LIB}" > ${D}/etc/env.d/10sbcl
}
