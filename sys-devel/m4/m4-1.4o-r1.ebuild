# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/m4/m4-1.4o-r1.ebuild,v 1.1 2000/08/03 14:16:17 achim Exp $

P=m4-1.4o      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNU macro processor"
CATEGORY="sys-devel"
SRC_URI="ftp://ftp.seindal.dk/gnu/${A}"
HOMEPAGE="http://www.gnu.org/software/m4/m4.html"

src_compile() {                           
    ./configure --prefix=/usr --with-modules --with-catgets --host=${CHOST}
    make
}

src_install() {                               
    into /usr
    cd ${S}
    make prefix=${D}/usr install
    prepman
    prepinfo
    insinto /usr/share/m4
    cd ${S}/examples
    doins *.m4
    cd ${S}
  
    dodoc AUTHORS BACKLOG COPYING NEWS README THANKS TODO
}


