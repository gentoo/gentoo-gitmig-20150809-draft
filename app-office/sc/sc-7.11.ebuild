# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/sc/sc-7.11.ebuild,v 1.1 2001/05/13 23:25:51 michael Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="sc is a free curses-based spreadsheet program that uses key bindings similar to vi and less."
SRC_URI="ftp://ibiblio.org/pub/Linux/apps/financial/spreadsheet/${A}"
HOMEPAGE=""

DEPEND="virtual/glibc
        >=sys-libs/ncurses-5.2"

src_compile() {
    try make prefix=/usr
}

src_install () {
    dodir /usr/bin
    dodir /usr/share/man/man1
    dodir /usr/lib/sc
    try make prefix=${D}/usr MANDIR=${D}/usr/share/man/man1 install
 
    dodoc CHANGES README sc.doc psc.doc tutorial.sc
    dodoc VMS_NOTES sc-7.11.lsm TODO SC.MACROS
}

# vim: ai et sw=4 ts=4
