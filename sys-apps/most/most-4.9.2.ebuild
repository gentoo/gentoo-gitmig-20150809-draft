# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/most/most-4.9.2.ebuild,v 1.4 2002/07/21 20:24:53 gerk Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="An extremely excellent text file reader"
HOMEPAGE=""
KEYWORDS="x86 -ppc"
SLOT="0"
LICENSE="GPL-2"
SRC_URI="ftp://space.mit.edu/pub/davis/most/${A}"

DEPEND=">=sys-libs/slang-1.4.2
        >=sys-libs/ncurses-5.2-r2"

src_compile() {

    try ./configure 	\
	--host=${CHOST} \
	--prefix=/usr \
	--sysconfdir=/etc

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


