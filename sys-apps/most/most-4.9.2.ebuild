# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/most/most-4.9.2.ebuild,v 1.12 2003/06/21 21:19:40 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An extremely excellent text file reader"
HOMEPAGE="http://freshmeat.net/projects/most/"
KEYWORDS="x86 amd64 -ppc"
SLOT="0"
LICENSE="GPL-2"
SRC_URI="ftp://space.mit.edu/pub/davis/most/${P}.tar.gz"

DEPEND=">=sys-libs/slang-1.4.2
        >=sys-libs/ncurses-5.2-r2"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc || die

	#*possible* (not definite) pmake problems, let's not risk it.
	make SYS_INITFILE="/etc/most.conf" || die
}

src_install() {
	dobin src/x86objs/most
	doman most.1

	dodoc COPYING COPYRIGHT README changes.txt
	docinto txt 
	dodoc default.rc lesskeys.rc most-fun.txt
}
