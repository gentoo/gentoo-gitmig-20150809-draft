# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/strace/strace-4.2-r2.ebuild,v 1.1 2000/11/14 14:57:55 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A usefull diagnostic, instructional, adn debugging tool"
SRC_URI="http://www.wi.leidenuniv.nl/~wichert/strace/${A}"
HOMEPAGE="http://www.wi.leidenuniv.nl/~wichert/strace/"
DEPEND=">=sys-libs/glibc-2.1.3"

src_unpack () {
  unpack ${A}
  cd ${S}
  if [ -n "`use glibc22`" ]
  then
    cp ${FILESDIR}/stream.c .
  fi
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




