# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/ttf2pt1/ttf2pt1-3.3.2.ebuild,v 1.1 2000/11/26 12:38:11 achim Exp $

A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="Converts True Type to Type 1 fonts"
SRC_URI="http://download.sourceforge.net/ttf2pt1/${A}"
HOMEPAGE="http://ttf2pt1.sourceforge.net"

DEPEND=">=sys-libs/glibc-2.1.3"

src_unpack() {
  unpack ${A}
  cd ${S}
  cp Makefile Makefile.orig
  sed -e "s:CFLAGS= -O:CFLAGS= ${CFLAGS}:" Makefile.orig > Makefile

}

src_compile() {

    cd ${S}
    try make all

}

src_install () {

    cd ${S}
    into /usr
    dobin t1asm ttf2pt1
    dodoc CHANGES COPYRIGHT README

}

