# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achime@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/t1utils/t1utils-1.23.ebuild,v 1.2 2002/04/28 03:59:30 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Type 1 Font utilities"
SRC_URI="http://www.lcdf.org/~eddietwo/type/${P}.tar.gz"
HOMEPAGE="http://www.lcdf.org/~eddietwo/"

DEPEND="virtual/glibc"

src_compile() {

	./configure --prefix=/usr --mandir=/usr/share/man || die
	make || die

}

src_install () {

	make DESTDIR=${D} install || die
	dodoc NEWS README

}
