# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/strace/strace-4.3.ebuild,v 1.4 2002/07/11 06:30:25 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A usefull diagnostic, instructional, adn debugging tool"
SRC_URI="mirror://sourceforge/strace/${P}.tar.bz2"
HOMEPAGE="http://www.wi.leidenuniv.nl/~wichert/strace/"
DEPEND="virtual/glibc"

src_compile() {
    cd ${S}
    try ./configure --prefix=/usr
    try make
}

src_install () {
    cd ${S}
    doman strace.1
    dobin strace 
    dobin strace-graph
    dodoc ChangeLog COPYRIGHT CREDITS NEWS PORTING README* TODO
}




