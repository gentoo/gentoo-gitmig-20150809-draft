# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author  Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/ispell/ispell-3.1.20-r1.ebuild,v 1.1 2001/03/06 06:20:41 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${PN}-3.1
DESCRIPTION="Ispell is a fast screen-oriented spelling checker"
SRC_URI="ftp://ftp.cs.ucla.edu/pub/ispell-3.1/${A}"
HOMEPAGE="http://fmg-www.cs.ucla.edu/geoff/ispell.html"

src_unpack() {

  unpack ${A}
  cd ${S}
  gzip -dc ${FILESDIR}/${P}.diff.gz | patch -p1

}

src_compile() {

    export PATH=$PATH:$PWD
    try make -f Makefile.Linux compile

}

src_install () {

    dobin buildhash findaffix icombine ijoin ispell \
	  munchlist sq tryaffix unsq

    doman *.[1-5]
    doinfo *.info

    insinto /usr/share/emacs/site-lisp
    doins ispell.el suse/*.el suse/emacs/*.el
    
    insinto /usr/lib/ispell
    doins languages/{american,british}/*.hash
    doins languages/english/english.aff

    dodoc Contributors README WISHES

}

