# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ald/ald-0.1.7.ebuild,v 1.3 2007/07/12 01:05:41 mr_bones_ Exp $

DESCRIPTION="Assembly Language Debugger - a tool for debugging executable programs at the assembly level"
HOMEPAGE="http://ald.sourceforge.net/"
SRC_URI="mirror://sourceforge/ald/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="ncurses"
DEPEND="ncurses? ( sys-libs/ncurses )"
RDEPEND="virtual/libc
	ncurses? ( sys-libs/ncurses )"

src_compile() {
	econf $(use_enable ncurses curses) || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README ChangeLog TODO BUGS
}
