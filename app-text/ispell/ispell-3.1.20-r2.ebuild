# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author  Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/ispell/ispell-3.1.20-r2.ebuild,v 1.1 2002/01/04 20:40:05 danarmak Exp $

A=${P}.tar.gz
S=${WORKDIR}/${PN}-3.1
DESCRIPTION="Ispell is a fast screen-oriented spelling checker"
SRC_URI="ftp://ftp.cs.ucla.edu/pub/ispell-3.1/${A}"
HOMEPAGE="http://fmg-www.cs.ucla.edu/geoff/ispell.html"

DEPEND="virtual/glibc >=sys-libs/ncurses-5.2"
src_unpack() {

  unpack ${A}
  cd ${S}
  patch -p1 < ${FILESDIR}/${P}.diff

}

src_compile() {

    export PATH=$PATH:$PWD
    make -f Makefile.Linux compile || die

}

src_install () {

    dobin buildhash findaffix icombine ijoin ispell \
	  munchlist sq tryaffix unsq

    doman *.[1-5]
    doinfo *.info

    insinto /usr/share/emacs/site-lisp
    doins ispell.el suse/*.el suse/emacs/*.el
    
    insinto /usr/lib/ispell
    doins languages/{american,british}/*.{hash,med}
    doins languages/english/english.aff

    dodoc Contributors README WISHES

    cd ${D}/usr/lib/ispell
    ${D}/usr/bin/buildhash english.med english.aff english.hash 
    
}