# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/flex/flex-2.5.4a-r1.ebuild,v 1.1 2000/08/03 14:16:17 achim Exp $

P=flex-2.5.4a      
A=${P}.tar.gz
S=${WORKDIR}/flex-2.5.4
CATEGORY="sys-devel"
DESCRIPTION="GNU lexical analyser generator"
SRC_URI="ftp://prep.ai.mit.edu/non-gnu/flex/${A}"
HOMEPAGE="http://www.gnu.org/software/flex/flex.html"

src_compile() {                           
    ./configure --prefix=/usr --host=${CHOST}
    make
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


