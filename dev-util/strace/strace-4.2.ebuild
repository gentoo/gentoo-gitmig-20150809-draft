# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/strace/strace-4.2.ebuild,v 1.2 2000/09/15 20:08:52 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A usefull diagnostic, instructional, adn debugging tool"
SRC_URI="http://www.wi.leidenuniv.nl/~wichert/strace/${A}"
HOMEPAGE="http://www.wi.leidenuniv.nl/~wichert/strace/"

src_unpack () {
  unpack ${A}
  cd ${S}
  cp time.c time.c.orig
  sed -e 's:<linux/timex\.h>:"linux/timex\.h":' time.c.orig > time.c
  cp ${FILESDIR}/timex.h linux
}
src_compile() {

    cd ${S}
    try ./configure --prefix=/usr i486-linux
    try make

}

src_install () {

    cd ${S}
    doman strace.1
    dobin strace 
    dobin strace-graph
    dodoc ChangeLog COPYRIGHT CREDITS NEWS PORTING README* TODO

}




