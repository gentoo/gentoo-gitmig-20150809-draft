# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom <ryan@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/splitvt/splitvt-1.6.5.ebuild,v 1.1 2001/02/11 19:31:58 ryan Exp $

S=${WORKDIR}/splitvt-1.6.5
SRC_URI="http://www.devolution.com/~slouken/projects/splitvt/splitvt-1.6.5.tar.gz"

HOMEPAGE="http://www.devolution.com/~slouken/projects/splitvt"

DESCRIPTION="A program for splitting terminals into two shells"

DEPEND=">=sys-libs/glibc-2.1.3"

src_unpack() {
    
    unpack ${A}
    cd ${S}
    cp config.c config.orig
    cat config.orig | sed "s:/usr/local/bin:${D}/usr/bin:g" > config.c

}
	 
src_compile() {

    try ./configure
    try make

}

src_install() {

    dodir /usr/bin
    try make install
    dodoc ANNOUNCE BLURB CHANGES NOTES README TODO
    doman splitvt.1

}
