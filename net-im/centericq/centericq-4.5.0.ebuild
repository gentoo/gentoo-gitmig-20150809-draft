# Copyright 1999-2002 Gentoo Technologies, Inc
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Shachar Goldin <aldarsior@yahoo.com>, Maintainer Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/centericq/centericq-4.5.0.ebuild,v 1.1 2002/01/26 23:17:03 verwilst Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A ncurses ICQ/Yahoo!/MSN Client"
SRC_URI="http://konst.org.ua/download/${P}.tar.gz"
HOMEPAGE="http://konst.org.ua/eng/software/centericq/info.html"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	>=dev-libs/libsigc++-1.0.4"

src_unpack() {

    unpack ${P}.tar.gz
    #patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
    cd ${S}
    echo "CFLAGS += ${CFLAGS}" >> Makefile.rules

}
src_compile() {

    ./configure --prefix=/usr --host=${CHOST} || die
     emake || die

}

src_install () {
	
    make DESTDIR=${D} install || die
    #dobin src/centericq
    #dodoc README FAQ

}


