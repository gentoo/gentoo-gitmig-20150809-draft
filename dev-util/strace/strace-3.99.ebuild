# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/strace/strace-3.99.ebuild,v 1.2 2000/11/27 16:20:46 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A usefull diagnostic, instructional, adn debugging tool"
SRC_URI="http://download.sourceforge.net/strace/${A}"
HOMEPAGE="http://sourceforge.net/projects/strace/"
DEPEND=">=sys-libs/glibc-2.1.3"

src_unpack () {
  unpack ${A}
  cp ${FILESDIR}/ipc.c ${S}
  cp ${FILESDIR}/stream.c ${S}
  
}
src_compile() {

    cd ${S}
    try ./configure --prefix=/usr ${CHOST}
    try make

}

src_install () {

    cd ${S}
    doman strace.1
    dobin strace 
    dodoc ChangeLog COPYRIGHT CREDITS NEWS PORTING README* TODO

}




