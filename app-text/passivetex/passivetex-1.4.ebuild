# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/app-text/passivetex/passivetex-1.4.ebuild,v 1.1 2001/03/17 22:40:54 achim Exp $

A=passivetex.zip
S=${WORKDIR}/passivetex
DESCRIPTION="A namespace-aware XML parser written in Tex"
SRC_URI="http://users.ox.ac.uk/~rahtz/passivetex/${A}"
HOMEPAGE="http://users.ox.ac.uk/~rahtz/passivetex/"

DEPEND="app-text/tetex
	app-text/xmltex"

src_unpack() {
    mkdir ${S}
    cd ${S}
    unpack ${A}
    cp ${FILESDIR}/${P}-Makefile Makefile
}

src_compile() {
    try make
}

src_install () {

    try make DESTDIR=${D} install

}

pkg_postinst() {
  if [ -e /usr/bin/mktexlsr ]
  then
    /usr/bin/mktexlsr
  fi
}
