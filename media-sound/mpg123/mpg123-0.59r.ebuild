# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpg123/mpg123-0.59r.ebuild,v 1.1 2000/08/15 21:24:56 achim Exp $

P=mpg123-0.59r
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="media-sound"
DESCRIPTION="Real Time mp3 player"
SRC_URI="http://www.mpg123.de/mpg123/${A}"
HOMEPAGE="http://www.mpg123.de/"

src_unpack () {
    unpack ${A}
    cd ${S}
    cp Makefile Makefile.orig
    sed -e "s:-O2 -m486:${CFLAGS}:" Makefile.orig > Makefile
}

src_compile() {

    cd ${S}
    make linux-i486

}

src_install () {

    cd ${S}
    into /usr
    dobin mpg123
    doman mpg123.1
    dodoc BENCHMARKING BUGS CHANGES COPYING JUKEBOX README* TODO


}


