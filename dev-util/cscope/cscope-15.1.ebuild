# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author AJ Lewis <lewis@sistina.com>

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="CScope - interactively examine a C program"
SRC_URI="http://download.sourceforge.net/cscope/${A}"
HOMEPAGE="http://cscope.sourceforge.net"

DEPEND="virtual/glibc
	>=sys-lib/ncurses-5.2"

src_compile() {                           
   try ./configure --prefix=/usr/ --mandir=/usr/share/man --infodir=/usr/share/info
   try make clean
   try make ${MAKEOPTS}
}

src_install() {                               
    try make prefix=${D}/usr/ mandir=${D}/usr/share/man infodir=${D}/usr/share/info install
    dodoc NEWS AUTHORS TODO COPYING Changelog INSTALL README*
}




