# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/sbcl/sbcl-0.6.12.ebuild,v 1.6 2002/07/16 16:08:59 phoenix Exp $


S=${WORKDIR}/${P}

DESCRIPTION="SteelBank Common Lisp"

SRC_URI="mirror://sourceforge/sbcl/${P}-source.tar.bz2
         mirror://sourceforge/sbcl/${P}-linux-binary.tar.bz2"

HOMEPAGE="http://sbcl.sf.net/"

PROVIDE="virtual/commonlisp"

LICENSE="PD"
SLOT="0"
KEYWORDS="x86"

src_unpack() {

    cd ${S}

    unpack ${P}-linux-binary.tar.bz2 ; mv ${P} ${P}-binary
    unpack ${P}-source.tar.bz2
}

src_compile() {

    export SBCL_HOME="../${P}-binary/output/" 
    export GNUMAKE="make"
    try sh make.sh "../${P}-binary/src/runtime/sbcl"

    if which jade > /dev/null ; then
      cd doc ;
      try sh make-doc.sh ;
    else 
      echo "Jade missing: Not building documentation" ;
    fi
}

src_install() {

    into /usr
 
    doman doc/sbcl.1
    dobin src/runtime/sbcl

    dodoc BUGS CREDITS NEWS README INSTALL COPYING 

    dodir /usr/share/sbcl
    cp output/sbcl.core ${D}/usr/share/sbcl/

}
