# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/t1utils/t1utils-1.25.ebuild,v 1.10 2004/02/22 20:07:12 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Type 1 Font utilities"
SRC_URI="http://www.lcdf.org/type/${P}.tar.gz"
HOMEPAGE="http://www.lcdf.org/type/#t1utils"
KEYWORDS="x86 sparc"
SLOT="0"
LICENSE="BSD"

DEPEND="virtual/glibc"

src_compile() {

	./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} || die
	emake || die

}

src_install () {

	make DESTDIR=${D} install || die
	dodoc NEWS README

}
