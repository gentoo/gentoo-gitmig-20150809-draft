# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netwatch/netwatch-1.0a.ebuild,v 1.2 2004/01/21 20:37:49 genone Exp $

SRC_URI="http://www.slctech.org/~mackay/${P}.src.tgz"
DESCRIPTION="a ncurses based network monitoring program"
HOMEPAGE="http://www.slctech.org/~mackay/netwatch.html"

LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""
SLOT="0"

DEPEND="sys-libs/ncurses
	>=sys-apps/sed-4.0.7"

src_unpack() {
	unpack ${A}
	sed -i "s:<sys/time.h>:<sys/time.h>\n#include <time.h>:" "${S}/netwatch.c"
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	exeinto /usr/sbin
	doexe netwatch netresolv
	doman netwatch.1
	dodoc BUGS CHANGES COPYING README README.performance TODO
}
