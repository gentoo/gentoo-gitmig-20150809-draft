# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/mudix/mudix-4.3-r1.ebuild,v 1.1 2008/05/15 13:00:36 nyhm Exp $

inherit games

DESCRIPTION="A small, stable MUD client for the console"
HOMEPAGE="http://dw.nl.eu.org/mudix.html"
SRC_URI="http://dw.nl.eu.org/mudix/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_compile() {
	egamesconf || die
	emake -C src O_FLAGS="${CFLAGS}" || die "emake failed"
}

src_install () {
	dogamesbin mudix || die "dogamesbin failed"
	dodoc README sample.usr
}
