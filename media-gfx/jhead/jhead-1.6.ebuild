# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Chris Arndt <arndtc@theeggbeater.dyndns.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/jhead/jhead-1.6.ebuild,v 1.1 2002/04/13 23:18:38 verwilst Exp $

S=${WORKDIR}/${PN}1.6
DESCRIPTION="a program for making thumbnails for websites."
SRC_URI="http://www.sentex.net/~mwandel/jhead/${P}.tar.gz"
HOMEPAGE="http://www.sentex.net/~mwandel/jhead/"

DEPEND="virtual/glibc"

src_compile() {

    cd ${S}
    emake || die
}

src_install () {

    dobin jhead  
    dodoc readme.txt changes.txt
}

