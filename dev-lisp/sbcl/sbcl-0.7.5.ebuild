# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author: Marius Bernklev <mariube@unixcore.com>
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/sbcl/sbcl-0.7.5.ebuild,v 1.1 2002/07/16 16:08:59 phoenix Exp $

DESCRIPTION="Steel Bank Common Lisp"

HOMEPAGE="http://sbcl.sf.net/"

LICENSE="PD"

BOOTSTRAPPER="0.7.2"

BIN=${PN}-${BOOTSTRAPPER}

SRC_URI="mirror://sourceforge/sbcl/${P}-source.tar.bz2
	 mirror://sourceforge/sbcl/${BIN}-x86-linux-binary.tar.bz2
	 mirror://sourceforge/sbcl/${P}-html.tar.bz2"

SLOT="0"

KEYWORDS="x86"

PROVIDE="virtual/commonlisp"

src_unpack() {
    unpack ${BIN}-x86-linux-binary.tar.bz2
    mv ${BIN} ${BIN}-binary
    
    unpack ${P}-source.tar.bz2
    unpack ${P}-html.tar.bz2
}

src_compile() {
    export SBCL_HOME="../${BIN}-binary/output/" 
    export GNUMAKE="emake"
    sh make.sh "../${BIN}-binary/src/runtime/sbcl" || die
}

src_install() {
    doman doc/sbcl.1
    dobin src/runtime/sbcl

    dodoc BUGS CREDITS NEWS README INSTALL COPYING 
    dohtml doc/html/*

    # NOTE: sbcl.core is platform dependent, which is why I moved it
    # away from /usr/share/

    LIB=${DESTTREE}/lib/sbcl

    dodir ${LIB}
    cp output/sbcl.core ${D}${LIB}

    dodir /etc/env.d

    echo "SBCL_HOME=${LIB}" > ${D}/etc/env.d/10sbcl
}

pkg_postinst() {
    env-update
}

pkg_postrm() {
    env-update
}
