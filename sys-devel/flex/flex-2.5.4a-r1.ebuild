# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/flex/flex-2.5.4a-r1.ebuild,v 1.4 2000/10/03 16:02:06 achim Exp $

P=flex-2.5.4a      
A=${P}.tar.gz
S=${WORKDIR}/flex-2.5.4
DESCRIPTION="GNU lexical analyser generator"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/non-gnu/flex/${A}
	 ftp://prep.ai.mit.edu/non-gnu/flex/${A}"
HOMEPAGE="http://www.gnu.org/software/flex/flex.html"

src_compile() {                           
    try ./configure --prefix=/usr --host=${CHOST}
    try make
}

src_install() {                               
    into /usr
    dobin flex
    dosym flex /usr/bin/flex++
    insinto /usr/include
    doins FlexLexer.h
    insinto /usr/lib
    doins libfl.a
    doman flex.1
    dosym flex.1.gz /usr/man/man1/flex++.1.gz
    dodoc COPYING NEWS README
}


