# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/sc/sc-7.12.ebuild,v 1.13 2004/03/19 03:27:51 weeve Exp $

DESCRIPTION="sc is a free curses-based spreadsheet program that uses key bindings similar to vi and less."
SRC_URI="ftp://ibiblio.org/pub/Linux/apps/financial/spreadsheet/${P}.tar.gz"
HOMEPAGE="http://ibiblio.org/pub/Linux/apps/financial/spreadsheet/"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="x86 ppc ~sparc"

DEPEND=">=sys-apps/sed-4.0.5
	>=sys-libs/ncurses-5.2"

src_compile() {
	make CFLAGS="-DSYSV3 $CFLAGS" prefix=/usr || die
}

src_install () {
	dodir /usr/bin
	dodir /usr/share/man/man1
	dodir /usr/lib/sc
	make prefix=${D}/usr MANDIR=${D}/usr/share/man/man1 install || die

	sed -i "s:${D}::g" sc.1
	doman sc.1 psc.1

	dodoc CHANGES README sc.doc psc.doc tutorial.sc
	dodoc VMS_NOTES ${P}.lsm TODO SC.MACROS
}

# vim: ai et sw=4 ts=4
