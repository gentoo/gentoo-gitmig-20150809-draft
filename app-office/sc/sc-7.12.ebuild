# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-office/sc/sc-7.12.ebuild,v 1.5 2002/08/01 13:09:06 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="sc is a free curses-based spreadsheet program that uses key bindings similar to vi and less."
SRC_URI="ftp://ibiblio.org/pub/Linux/apps/financial/spreadsheet/${P}.tar.gz"
HOMEPAGE=""

SLOT="0"
LICENSE="public-domain"
KEYWORDS="x86"

DEPEND=">=sys-libs/ncurses-5.2"

src_compile() {
	make CFLAGS="-DSYSV3 $CFLAGS" prefix=/usr || die
}

src_install () {
	dodir /usr/bin
	dodir /usr/share/man/man1
	dodir /usr/lib/sc
	make prefix=${D}/usr MANDIR=${D}/usr/share/man/man1 install || die
 
	dodoc CHANGES README sc.doc psc.doc tutorial.sc
	dodoc VMS_NOTES ${P}.lsm TODO SC.MACROS
}

# vim: ai et sw=4 ts=4
