# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/autotrace/autotrace-0.24a.ebuild,v 1.1 2000/09/20 19:57:21 achim Exp $

A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="Converts Bitmaps to vector-grahics"
SRC_URI="http://homepages.go.com/homepages/m/a/r/martweb/${A}"
HOMEPAGE="http://homepages.go.com/homepages/m/a/r/martweb/AutoTrace.htm"


src_compile() {

    try ./configure --prefix=/usr/X11R6 --host=${CHOST}
    cp Makefile Makefile.orig
    sed -e "s:\$(LINK):\$(LINK) -lXt:" Makefile.orig > Makefile
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README 
}

