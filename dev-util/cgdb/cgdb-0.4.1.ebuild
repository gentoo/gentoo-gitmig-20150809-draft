# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cgdb/cgdb-0.4.1.ebuild,v 1.3 2004/06/25 02:22:53 agriffis Exp $


DESCRIPTION="curses interface to the GNU debugger"
HOMEPAGE="http://sourceforge.net/projects/cgdb"
SRC_URI="mirror://sourceforge/cgdb/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=sys-libs/ncurses-5.3-r1
	>=sys-devel/gdb-5.3"

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README
}

