# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pbg1854@garnet.acns.fsu.edu>
# $Header: /var/cvsroot/gentoo-x86/media-sound/cd-discid/cd-discid-0.6.ebuild,v 1.1 2001/04/23 01:00:39 pete Exp $

A=${PN}_${PV}.orig.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="returns the disc id for the cd in the cd-rom drive"
SRC_URI="http://lly.org/~rcw/cd-discid/${A}"
HOMEPAGE="http://lly.org/~rcw/abcde/page/"


src_compile() {

    echo gcc ${CFLAGS} -o cd-discid cd-discid.c
    gcc ${CFLAGS} -o cd-discid cd-discid.c
}

src_install () {

    into /usr
    dobin cd-discid
    doman cd-discid.1

    dodoc COPYING README changelog
}
