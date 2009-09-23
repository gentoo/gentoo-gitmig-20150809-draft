# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ald/ald-0.1.7.ebuild,v 1.4 2009/09/23 17:39:22 patrick Exp $

DESCRIPTION="Assembly Language Debugger - a tool for debugging executable programs at the assembly level"
HOMEPAGE="http://ald.sourceforge.net/"
SRC_URI="mirror://sourceforge/ald/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="ncurses"
DEPEND="ncurses? ( sys-libs/ncurses )"
RDEPEND="${DEPEND}"

src_compile() {
	econf $(use_enable ncurses curses) || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README ChangeLog TODO BUGS
}
