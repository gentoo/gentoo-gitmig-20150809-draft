# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvs/cvs-1.10.8-r1.ebuild,v 1.2 2000/08/16 04:37:59 drobbins Exp $

P=cvs-1.10.8
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Concurrent Versions System - source code revision control tools"
SRC_URI="ftp://ftp.cvshome.org/pub/cvs-1.10.8/cvs-1.10.8.tar.gz"
HOMEPAGE="http://www.cyclic.com/"

src_compile() {                           
    ./configure --prefix=/usr
    make ${MAKEOPTS} "MAKE = make ${MAKEOPTS}"
}

src_install() {                               
    into /usr
    make prefix=${D}/usr install
    strip ${D}/usr/bin/*
    prepman
    prepinfo
    dodoc BUGS COPYING* DEVEL* FAQ HACKING MINOR* NEWS PROJECTS README* TESTS TODO
    ln -s /usr/lib/cvs/contrib ${D}/usr/doc/${P}/contrib
}



