# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-libs/readline/readline-4.2.ebuild,v 1.7 2002/07/16 03:47:31 gerk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Another cute console display library"
SRC_URI="ftp://ftp.gnu.org/gnu/readline/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
SLOT="0"
HOMEPAGE="http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2-r2"

RDEPEND="virtual/glibc"

src_compile() {

    try ./configure --host=${CHOST} --with-curses \
        --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info
    try make ${MAKEOPTS}
    cd shlib
    try make ${MAKEOPTS}

}


src_install() {

	try make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info install
	cd shlib
	try make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info install

	cd ..

        dodir /lib
	mv ${D}/usr/lib/*.so* ${D}/lib
	dosym libhistory.so.${PV} /lib/libhistory.so
	dosym libreadline.so.${PV} /lib/libreadline.so
	# Needed because make install uses ${D} for the link
	dosym libhistory.so.${PV} /lib/libhistory.so.4
	dosym libreadline.so.${PV} /lib/libreadline.so.4
	chmod 755 ${D}/lib/*.${PV}

        dodoc CHANGELOG CHANGES COPYING MANIFEST README USAGE
	docinto ps
	dodoc doc/*.ps
	docinto html
	dodoc doc/*.html


}




