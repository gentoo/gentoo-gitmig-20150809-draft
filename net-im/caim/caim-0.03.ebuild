# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Maintainer Bart Verwilst <verwilst@gentoo.org>, Author Ryan Tolboom <ryan@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/caim/caim-0.03.ebuild,v 1.3 2002/02/09 11:47:56 verwilst Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Console AIM Client"
SRC_URI="http://www.mercyground.co.uk/${P}.tar.gz"
HOMEPAGE="http://www.mercyground.co.uk"
SLOT="0"
DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.1"

src_unpack() {

    unpack ${P}.tar.gz
    patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
    cd ${S}
    echo "CFLAGS += ${CFLAGS}" >> Makefile.rules

}

src_compile() {

    emake || die

}

src_install () {

    dobin client/caim
    dolib libfaim.so
    dodoc README Changes
    docinto libfaim
    dodoc faimdocs/BUGS faimdocs/CHANGES faimdocs/README
 
}
