# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pbg1854@garnet.acns.fsu.edu>
# $Header: /var/cvsroot/gentoo-x86/media-sound/abcde/abcde-1.9.7.ebuild,v 1.1 2001/02/05 02:23:36 achim Exp $

A=abcde_1.9.7.orig.tar.gz
A0=abcde-1.9.7-gentoo.diff.gz

S=${WORKDIR}/${P}
DESCRIPTION="a better cd encoder"
SRC_URI="http://lly.org/~rcw/abcde/development/${A}"
HOMEPAGE="http://lly.org/~rcw/abcde/page/"
RDEPEND=">=media-sound/id3-0.12
         >=media-sound/cd-discid-0.12
         >=media-sound/cdparanoia-3.9.7"

src_unpack() {

    unpack ${A}
    cd ${S}
    gzip -dc ${FILESDIR}/${A0} | patch -p1
}

src_compile() {
    cd ${S}
}

src_install () {
    cd ${S}
    try make DESTDIR=${D} install
    dodoc COPYING README TODO changelog
}

