# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/plib/plib-1.4.1.ebuild,v 1.2 2002/07/11 06:30:39 drobbins Exp $

S=${WORKDIR}/${P}
SRC_URI="http://plib.sourceforge.net/dist/${P}.tar.gz"

HOMEPAGE="http://plib.sourceforge.net"
DESCRIPTION="plib: a multimedia library used by many games"

DEPEND="virtual/x11 virtual/glut"

src_compile() {
    
    confopts=" --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST}"
    
    try ./configure ${confopts}
    
    try emake

}

src_install () {

    try make DESTDIR=${D} install

}
