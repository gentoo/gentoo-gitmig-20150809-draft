# Copyright 1999-2002 Gentoo Technologies, Inc.
# Copyright 2002 Marius Bernklev <mariube@unixcore.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/sbcl/sbcl-0.7.6.ebuild,v 1.3 2002/07/29 15:56:25 karltk Exp $

DESCRIPTION="Steel Bank Common Lisp"
HOMEPAGE="http://sbcl.sourceforge.net/"

# ugly kludge, note that KEYWORDS should prevent sparc

TARCH=$([ $(arch) = ppc ] && echo "ppc" || echo "x86")

if [ ${TARCH} = "x86" ]; then
    BOOTSTRAPPER="0.7.2";
elif [ ${TARCH} = "ppc" ]; then
    BOOTSTRAPPER="0.7.6";
fi

BIN=${PN}-${BOOTSTRAPPER}

SRC_URI="mirror://sourceforge/sbcl/${P}-source.tar.bz2
	 mirror://sourceforge/sbcl/${BIN}-${TARCH}-linux-binary.tar.bz2
	 mirror://sourceforge/sbcl/${P}-html.tar.bz2"

LICENSE="MIT"
SLOT="0"

# Digest doesn't work on x86
KEYWORDS="-x86 ppc -sparc -sparc64" 
PROVIDE="virtual/commonlisp"
DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${BIN}-${TARCH}-linux-binary.tar.bz2
	if [ ${ARCH} == "x86" ] ; then
		mv ${BIN} ${BIN}-binary
	elif [ ${ARCH} == "ppc" ] ; then
		mv ${BIN}-${TARCH}-linux ${BIN}-binary
	fi
    
	unpack ${P}-source.tar.bz2
	unpack ${P}-html.tar.bz2
}

src_compile() {
	export SBCL_HOME="../${BIN}-binary/output/" 
	export GNUMAKE="make"
    
	sh make.sh "../${BIN}-binary/src/runtime/sbcl" || die
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
