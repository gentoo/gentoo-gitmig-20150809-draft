# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pbg1854@garnet.acns.fsu.edu>
# $Header: /var/cvsroot/gentoo-x86/media-sound/abcde/abcde-1.9.9.ebuild,v 1.2 2001/05/28 05:24:13 achim Exp $

A=${PN}_${PV}.orig.tar.gz

S=${WORKDIR}/${P}
DESCRIPTION="a better cd encoder"
SRC_URI="http://lly.org/~rcw/abcde/development/${A}"
HOMEPAGE="http://lly.org/~rcw/abcde/page/"
RDEPEND=">=media-sound/id3-0.12
         >=media-sound/cd-discid-0.6
         >=media-sound/cdparanoia-3.9.7"

src_unpack() {

    unpack ${A}
    cd ${S}
    cp Makefile Makefile.orig
    patch -p1 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
    cd ${S}
}

src_install () {
    cd ${S}
    dodir /etc/abcde
    try make DESTDIR=${D} install
    dodoc COPYING README TODO changelog
}

