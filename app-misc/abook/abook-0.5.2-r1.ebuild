# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/abook/abook-0.5.2-r1.ebuild,v 1.2 2004/03/27 17:04:46 rizzo Exp $

DESCRIPTION="Abook is a text-based addressbook program designed to use with mutt mail client."
HOMEPAGE="http://abook.sourceforge.net/"
SRC_URI="mirror://sourceforge/abook/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
DEPEND="sys-libs/ncurses
	sys-libs/readline"

#S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/abook-0.5.2-filter.diff
}

src_compile() {
	cd ${S}
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make install DESTDIR=${D} || die "install died"
	dodoc ANNOUNCE AUTHORS BUGS COPYING ChangeLog FAQ INSTALL NEWS README THANKS TODO
	dodoc sample.abookrc
}

