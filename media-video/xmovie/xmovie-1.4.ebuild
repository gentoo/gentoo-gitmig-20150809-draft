# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/xmovie/xmovie-1.4.ebuild,v 1.1 2000/08/15 19:26:39 achim Exp $

P=xmovie-1.4
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="media-video"
DESCRIPTION="A Player for MPEG and Quicktime movies"
SRC_URI="http://heroine.linuxave.net/${A}"
HOMEPAGE="http://heroine.linuxave.net/xmovie.html"


src_compile() {

    cd ${S}
    ./configure
    make

}

src_install () {

    cd ${S}
    into /usr/X11R6
    dobin xmovie/xmovie
    dodoc README
    docinto html
    dodoc docs/index.html

}


