# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# /home/cvsroot/gentoo-x86/skel.build,v 1.2 2001/02/15 18:17:31 achim Exp
# $Header: /var/cvsroot/gentoo-x86/app-text/mgv/mgv-3.1.5.ebuild,v 1.4 2001/08/31 03:23:38 pm Exp $


#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Gv is a Motif PostScript viewer loosely based on Ghostview"
SRC_URI="http://www.trends.net/~mu/srcs/${A}"
HOMEPAGE="http://www.trends.net/~mu/mgv.html"

DEPEND=">=app-text/ghostscript-3.33
        x11-libs/openmotif"

src_compile() {

    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README
    docinto sgml
    dodoc doc/*.sgml

}

