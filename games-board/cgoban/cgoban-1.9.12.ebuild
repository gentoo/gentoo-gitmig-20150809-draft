# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/cgoban/cgoban-1.9.12.ebuild,v 1.5 2004/07/14 14:28:16 agriffis Exp $

inherit games

DESCRIPTION="A Go-frontend"
SRC_URI="http://www.igoweb.org/~wms/comp/cgoban/${P}.tar.gz"
HOMEPAGE="http://www.igoweb.org/~wms/comp/cgoban/"

KEYWORDS="x86 ppc"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/libc
	virtual/x11"

src_compile() {
	egamesconf || die
	emake || die
}

src_install() {
	dogamesbin cgoban grab_cgoban
	doman man?/*.[1-9]
	prepgamesdirs
}
