# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/expat/expat-1.95.1-r1.ebuild,v 1.1 2001/02/27 15:36:32 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="XML parsing libraries"
SRC_URI="http://download.sourceforge.net/expat/${A}"
HOMEPAGE="http://expat.sourceforge.net"

DEPEND="virtual/glibc"

src_compile() {      
                     
	try ./configure --prefix=/usr
	try pmake
}

src_install() {                               

    try make DESTDIR=${D} install
    #try make prefix=${D}/usr install
	dodoc COPYING Changes MANIFEST README 
    docinto html
    dodoc doc/*
}



