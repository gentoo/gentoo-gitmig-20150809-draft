# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/expat/expat-1.95.1.ebuild,v 1.1 2001/02/08 18:03:19 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="XML parsing libraries"
#FIX
#SRC_URI="http://www.openssl.org/source/${A}"
#HOMEPAGE="http://www.opensl.org/"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {                           
	try ./configure --prefix=/usr
	try pmake
}

src_install() {                               
    try make prefix=${D}/usr install
	dodoc ${S}/README
}



