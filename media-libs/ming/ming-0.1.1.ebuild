# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-libs/ming/ming-0.1.1.ebuild,v 1.1 2001/07/05 00:06:17 achim Exp $

A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="A OpenSource library from flash movie generation"
SRC_URI="http://www.opaque.net/ming/${A}"
HOMEPAGE="http://www.opaque.net/ming/"

DEPEND="virtual/glibc"
src_unpack() {
  unpack ${A}
  cd ${S}/util
  patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {

    try make
    cd util
    try make bindump hexdump listswf listfdb listmp3 listjpeg makefdb swftophp
}

src_install () {

    dolib.so libming.so
    insinto /usr/include
    doins ming.h
    exeinto /usr/lib/ming
    doexe util/{bindump,hexdump,listswf,listfdb,listmp3,listjpeg,makefdb,swftophp}
    dodoc CHANGES CREDITS LICENSE README TODO
    newdoc util/README README.util
    newdoc util/TODO TODO.util
}

