# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/abook/abook-0.5.2.ebuild,v 1.1 2004/03/08 16:20:40 rizzo Exp $

DESCRIPTION="Abook is a text-based addressbook program designed to use with mutt mail client."
HOMEPAGE="http://abook.sourceforge.net/"
SRC_URI="mirror://sourceforge/abook/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
DEPEND="sys-libs/ncurses
	sys-libs/readline"

#S="${WORKDIR}/${P}"

src_compile() {
	cd ${S}
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "install died"
	dodoc ANNOUNCE AUTHORS BUGS COPYING ChangeLog FAQ INSTALL NEWS README THANKS TODO
	dodoc sample.abookrc
}

