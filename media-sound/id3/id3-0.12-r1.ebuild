# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/id3/id3-0.12-r1.ebuild,v 1.4 2002/07/11 06:30:40 drobbins Exp $

A=${PN}_${PV}.orig.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="changes the id3 tag in an mp3 file"
SRC_URI="http://lly.org/~rcw/id3/${A}"
HOMEPAGE="http://lly.org/~rcw/abcde/page/"


src_compile() {

    try make CFLAGS="${CFLAGS}"
}

src_install () {

    try make DESTDIR=${D} INSTALL="/bin/install -c" install
    dodoc COPYING README

}
