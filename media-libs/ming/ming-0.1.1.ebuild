# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/ming/ming-0.1.1.ebuild,v 1.3 2002/07/11 06:30:39 drobbins Exp $

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
    try make static
    cd util
    try make bindump hexdump listswf listfdb listmp3 listjpeg makefdb swftophp
#    cd ${S}/php_ext
#    try make php_ming.so
}

src_install () {

    dolib.so libming.so
    dolib.a  libming.a
    insinto /usr/include
    doins ming.h
    exeinto /usr/lib/ming
    doexe util/{bindump,hexdump,listswf,listfdb,listmp3,listjpeg,makefdb,swftophp}
    dodoc CHANGES CREDITS LICENSE README TODO
    newdoc util/README README.util
    newdoc util/TODO TODO.util
}

