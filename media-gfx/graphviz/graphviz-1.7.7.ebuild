# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Aron Griffis <agriffis@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/graphviz/graphviz-1.7.7.ebuild,v 1.1 2001/10/19 17:03:38 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="open source graph drawing software"
SRC_URI="http://www.research.att.com/sw/tools/graphviz/dist/$P.tgz"
HOMEPAGE="http://www.research.att.com/sw/tools/graphviz/"

src_compile() {
    ./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST} || die
    make || die
}

src_install () {
    make DESTDIR=${D} install || die
}
