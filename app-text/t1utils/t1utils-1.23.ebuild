# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/t1utils/t1utils-1.23.ebuild,v 1.11 2004/03/12 08:28:27 mr_bones_ Exp $

DESCRIPTION="Type 1 Font utilities"
SRC_URI="http://www.lcdf.org/type/${P}.tar.gz"
HOMEPAGE="http://www.lcdf.org/type/#t1utils"
KEYWORDS="x86 sparc"
SLOT="0"
LICENSE="BSD"

DEPEND="virtual/glibc"

src_compile() {

	./configure --prefix=/usr --mandir=/usr/share/man || die
	make || die

}

src_install () {

	make DESTDIR=${D} install || die
	dodoc NEWS README

}
