# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-build/flex/flex-2.5.4a-r1.ebuild,v 1.3 2001/02/15 18:17:31 achim Exp $

P=flex-2.5.4a      
A=${P}.tar.gz
S=${WORKDIR}/flex-2.5.4
DESCRIPTION="GNU lexical analyser generator"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/non-gnu/flex/${A}
	 ftp://prep.ai.mit.edu/non-gnu/flex/${A}"
HOMEPAGE="http://www.gnu.org/software/flex/flex.html"

src_compile() {                           
    try ./configure --prefix=/usr --host=${CHOST} --disable-nls
    try make ${MAKEOPTS} LDFLAGS=-static
}

src_install() {
    try make prefix=${D}/usr install
    rm -rf ${D}/usr/man ${D}/usr/include ${D}/usr/lib
}


