# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvs/cvs-1.11.ebuild,v 1.1 2000/10/04 13:29:55 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Concurrent Versions System - source code revision control tools"
SRC_URI="ftp://ftp.cvshome.org/pub/${P}/${P}.tar.gz"
HOMEPAGE="http://www.cvshome.org/"

src_compile() {                           
    try ./configure --prefix=/usr
    try make
}

src_install() {                               
    into /usr
    try make prefix=${D}/usr install
    strip ${D}/usr/bin/*
    prepman
    prepinfo
    dodoc BUGS COPYING* ChangeLog* DEVEL* FAQ HACKING 
    dodoc MINOR* NEWS PROJECTS README* TESTS TODO
    ln -s /usr/lib/cvs/contrib ${D}/usr/doc/${P}/contrib
    insinto /usr/share/emacs/site-lisp
    doins cvs-format.el
}



