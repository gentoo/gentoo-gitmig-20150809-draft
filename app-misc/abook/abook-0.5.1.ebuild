# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/abook/abook-0.5.1.ebuild,v 1.1 2003/12/26 01:27:42 pyrania Exp $

DESCRIPTION="Abook is a text-based addressbook program designed to use with mutt mail client."
HOMEPAGE="http://abook.sourceforge.net/"
SRC_URI="mirror://sourceforge/abook/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
DEPEND="sys-libs/ncurses
	sys-libs/readline"

S=${WORKDIR}/${P}

src_compile() {
	cd ${S}
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ANNOUNCE AUTHORS BUGS COPYING ChangeLog FAQ INSTALL README THANKS TODO
	dodoc sample.abookrc
}
