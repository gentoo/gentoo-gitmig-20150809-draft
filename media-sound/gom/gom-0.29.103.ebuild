# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ryan Tolboom <ryan@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/gom/gom-0.29.103.ebuild,v 1.3 2001/08/11 03:50:11 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Console Mixer Program for OSS"
SRC_URI="http://www.Fh-Worms.DE./~inf222/code/c/gom/released/{A}"
HOMEPAGE="http://www.fh-worms.de/~inf222"

DEPEND=">=sys-libs/ncurses-5.2"

src_compile() {

    try ./configure --prefix=/usr --mandir=/usr/share/man
    try make CFLAGS="${CFLAGS}"

}

src_install () {

    try make DESTDIR=${D} install
    dodoc NEWS ChangeLog README
    docinto examples
    dodoc README 
    docinto examples/default
    dodoc examples/default/*
    docinto examples/standard
    dodoc examples/standard/*
    docinto examples/two-mixers
    dodoc examples/two-mixers/*

}
