# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/gom/gom-0.29.103-r1.ebuild,v 1.4 2002/07/11 06:30:40 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Console Mixer Program for OSS"
SRC_URI="http://www.Fh-Worms.DE./~inf222/code/c/gom/released/${P}.tar.gz"
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
