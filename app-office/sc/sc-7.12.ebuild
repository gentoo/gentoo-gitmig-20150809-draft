# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/sc/sc-7.12.ebuild,v 1.2 2001/08/11 04:42:31 drobbins Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="sc is a free curses-based spreadsheet program that uses key bindings similar to vi and less."
SRC_URI="ftp://ibiblio.org/pub/Linux/apps/financial/spreadsheet/${A}"
HOMEPAGE=""

DEPEND="virtual/glibc
        >=sys-libs/ncurses-5.2"

src_compile() {
    try make CFLAGS="-DSYSV3 $CFLAGS" prefix=/usr
}

src_install () {
    dodir /usr/bin
    dodir /usr/share/man/man1
    dodir /usr/lib/sc
    try make prefix=${D}/usr MANDIR=${D}/usr/share/man/man1 install
 
    dodoc CHANGES README sc.doc psc.doc tutorial.sc
    dodoc VMS_NOTES ${P}.lsm TODO SC.MACROS
}

# vim: ai et sw=4 ts=4
