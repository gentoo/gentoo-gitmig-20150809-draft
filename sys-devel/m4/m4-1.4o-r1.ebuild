# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/m4/m4-1.4o-r1.ebuild,v 1.3 2000/09/15 20:09:26 drobbins Exp $

P=m4-1.4o      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNU macro processor"
SRC_URI="ftp://ftp.seindal.dk/gnu/${A}"
HOMEPAGE="http://www.gnu.org/software/m4/m4.html"

src_compile() {                           
    try ./configure --prefix=/usr --with-modules --with-catgets --host=${CHOST}
    try make
}

src_install() {                               
    into /usr
    cd ${S}
    try make prefix=${D}/usr install
    prepman
    prepinfo
    insinto /usr/share/m4
    cd ${S}/examples
    doins *.m4
    cd ${S}
  
    dodoc AUTHORS BACKLOG COPYING NEWS README THANKS TODO
}


