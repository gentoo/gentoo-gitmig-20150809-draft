# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/t1utils/t1utils-1.25.ebuild,v 1.15 2005/01/01 16:37:22 eradicator Exp $

DESCRIPTION="Type 1 Font utilities"
SRC_URI="http://www.lcdf.org/type/${P}.tar.gz"
HOMEPAGE="http://www.lcdf.org/type/#t1utils"
KEYWORDS="x86 sparc"
IUSE=""
SLOT="0"
LICENSE="BSD"

DEPEND="virtual/libc"

src_compile() {

	./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} || die
	emake || die

}

src_install () {

	make DESTDIR=${D} install || die
	dodoc NEWS README

}
