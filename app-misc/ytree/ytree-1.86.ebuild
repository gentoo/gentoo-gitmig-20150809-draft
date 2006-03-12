# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ytree/ytree-1.86.ebuild,v 1.1 2006/03/12 23:03:29 jokey Exp $

DESCRIPTION="A (curses-based) file manager"
HOMEPAGE="http://www.han.de/~werner/ytree.html"
SRC_URI="http://www.han.de/~werner/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-libs/readline
	sys-libs/ncurses"
RDEPEND=""

src_compile() {
	emake || die
}

src_install() {
	dobin ytree
	doman ytree.1
}
